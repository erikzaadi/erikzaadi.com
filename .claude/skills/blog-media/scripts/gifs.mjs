#!/usr/bin/env node
// Finds and downloads GIFs from Giphy. Picking takes taste, so search only lists candidates.
//   gifs.mjs search "query" [--limit 8] [--rating pg-13]   (needs GIPHY_API_KEY)
//   gifs.mjs download <giphy id or URL> <out.gif>          (no key needed)
// Ported from https://github.com/erikzaadi/nerdalicous-presentation-skill (scripts/find-gifs.mjs)

import { mkdir, writeFile } from 'node:fs/promises'
import { dirname, resolve } from 'node:path'
import { parseArgs } from 'node:util'

try {
  process.loadEnvFile('.env')
} catch (error) {
  if (error.code !== 'ENOENT') throw error
}

const { values: args, positionals } = parseArgs({
  allowPositionals: true,
  options: {
    limit: { type: 'string', default: '8' },
    rating: { type: 'string', default: process.env.GIPHY_RATING ?? 'pg-13' },
  },
})
const [command, ...rest] = positionals

if (command === 'search' && rest.length) {
  await search(rest.join(' '))
} else if (command === 'download' && rest.length === 2) {
  await download(rest[0], rest[1])
} else {
  fail('Usage: gifs.mjs search "query" [--limit 8] [--rating pg-13]  |  gifs.mjs download <id or URL> <out.gif>')
}

async function search(text) {
  const limit = Number(args.limit)
  if (!Number.isInteger(limit) || limit < 1 || limit > 50) fail('--limit must be between 1 and 50')
  if (!['g', 'pg', 'pg-13', 'r'].includes(args.rating)) fail('--rating must be g, pg, pg-13 or r')
  if (!process.env.GIPHY_API_KEY) fail('GIPHY_API_KEY is not set (put it in .env at the repo root)')

  const query = fitWords(text, 50) // Giphy answers 414 past 50 characters
  const url = new URL('https://api.giphy.com/v1/gifs/search')
  url.search = new URLSearchParams({ api_key: process.env.GIPHY_API_KEY, q: query, limit: String(limit), rating: args.rating, lang: 'en' })
  const response = await fetch(url, { signal: AbortSignal.timeout(30_000) })
  if (response.status === 401 || response.status === 403) fail(`Giphy rejected GIPHY_API_KEY (${response.status})`)
  if (response.status === 429) fail("Giphy's rate limit for this key is used up; wait an hour.")
  if (!response.ok) fail(`Giphy API ${response.status}: ${await response.text()}`)

  const gifs = (await response.json()).data
  console.log(`${gifs.length} results for "${query}" (more: ${searchUrl(query)})\n`)
  for (const gif of gifs) {
    const original = gif.images.original
    console.log(`  ${gif.id}  ${gif.title || gif.slug}  ${original.width}x${original.height}, ${megabytes(original.size)}`)
    console.log(`      ${gif.url}\n`)
  }
}

async function download(pick, out) {
  const id = parsePick(pick) ?? fail(`Can't read a Giphy id from "${pick}"`)
  // the plain media URL needs no API key
  const response = await fetch(`https://media.giphy.com/media/${id}/giphy.gif`, { signal: AbortSignal.timeout(120_000) })
  if (!response.ok || response.headers.get('content-type') !== 'image/gif') fail(`Giphy returned ${response.status} for GIF ${id}`)
  const gif = Buffer.from(await response.arrayBuffer())
  const outPath = resolve(out)
  await mkdir(dirname(outPath), { recursive: true })
  await writeFile(outPath, gif)
  console.log(`Saved ${outPath} (${megabytes(gif.length)})`)
}

function fitWords(text, max) {
  let result = ''
  for (const word of text.split(/\s+/u).filter(Boolean)) {
    const next = result ? `${result} ${word}` : word
    if (next.length > max) break
    result = next
  }
  return result || text.slice(0, max)
}

/** A Giphy id from an id, a giphy.com/gifs/<slug>-<id> page, or a media.giphy.com / i.giphy.com URL. */
function parsePick(pick) {
  const value = pick.trim()
  if (/^[A-Za-z0-9]+$/u.test(value)) return value
  let url
  try {
    url = new URL(value)
  } catch {
    return null
  }
  if (!/(^|\.)giphy\.com$/u.test(url.hostname)) return null
  const parts = url.pathname.split('/').filter(Boolean)
  const media = parts.indexOf('media')
  if (media !== -1) return parts.at(media + 1)?.match(/^[A-Za-z0-9]+$/u)?.[0] ?? null
  if (url.hostname === 'i.giphy.com') return parts.at(-1)?.replace(/\.\w+$/u, '') ?? null
  return parts.at(-1)?.split('-').at(-1) ?? null
}

function searchUrl(query) {
  return `https://giphy.com/search/${encodeURIComponent(query.toLowerCase().replace(/\s+/gu, '-'))}`
}

function megabytes(bytes) {
  return `${(Number(bytes) / 1_000_000).toFixed(1)} MB`
}

function fail(message) {
  console.error(`Error: ${message}`)
  process.exit(1)
}
