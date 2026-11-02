#!/usr/bin/env node
// Makes a meme image with memegen.link: free, no account, no API key.
//   meme.mjs --templates <word>                          search template ids
//   meme.mjs <template> <out.png> "top line" "bottom line" [--width 1200] [--force]
// Ported from https://github.com/erikzaadi/nerdalicous-presentation-skill (scripts/generate-memes.mjs)

import { access, mkdir, writeFile } from 'node:fs/promises'
import { dirname, extname, resolve } from 'node:path'
import { parseArgs } from 'node:util'

const api = 'https://api.memegen.link'
const { values: args, positionals } = parseArgs({
  allowPositionals: true,
  options: {
    templates: { type: 'string' },
    width: { type: 'string', default: '1200' },
    force: { type: 'boolean' },
  },
})

if (args.templates) {
  const templates = await getJson(`${api}/templates?filter=${encodeURIComponent(args.templates)}`)
  if (!templates.length) console.log(`No templates match "${args.templates}". Browse them all at ${api}/templates`)
  for (const t of templates) {
    console.log(`  ${t.id.padEnd(16)} ${t.name} (${t.lines} line${t.lines === 1 ? '' : 's'})  ${t.example.url}`)
  }
  process.exit(0)
}

const [templateId, out, ...lines] = positionals
if (!templateId || !out || !lines.length) {
  fail('Usage: meme.mjs <template> <out.png> "line 1" ["line 2" ...]  |  meme.mjs --templates <word>')
}
const format = extname(out).slice(1).toLowerCase()
if (!['png', 'jpg', 'gif', 'webp'].includes(format)) fail('out must end in .png, .jpg, .gif (animated templates) or .webp')
if (!/^\d+$/u.test(args.width)) fail('--width must be a number of pixels')
const outPath = resolve(out)
if (!args.force && (await access(outPath).then(() => true, () => false))) fail(`${out} exists (--force to remake)`)

const template = await getJson(`${api}/templates/${encodeURIComponent(templateId)}`).catch(() =>
  fail(`No memegen template "${templateId}". Search with --templates <word>`),
)
if (lines.length > template.lines) {
  console.log(`Warning: ${template.id} has ${template.lines} text line(s), got ${lines.length}; the extra ones are dropped.`)
}
const url = `${api}/images/${encodeURIComponent(templateId)}/${lines.map(escapeLine).join('/')}.${format}?width=${args.width}`
const response = await fetch(url, { signal: AbortSignal.timeout(60_000) })
if (!response.ok || !response.headers.get('content-type')?.startsWith('image/')) fail(`memegen returned ${response.status} for ${url}`)
await mkdir(dirname(outPath), { recursive: true })
await writeFile(outPath, Buffer.from(await response.arrayBuffer()))
console.log(`Saved ${outPath}. Look at it first: the text fits and the joke still lands.`)

/** memegen's path escaping: https://github.com/jacebrowning/memegen#special-characters */
function escapeLine(line) {
  if (!line) return '_'
  const escaped = line
    .replace(/_/gu, '__')
    .replace(/-/gu, '--')
    .replace(/\?/gu, '~q')
    .replace(/&/gu, '~a')
    .replace(/%/gu, '~p')
    .replace(/#/gu, '~h')
    .replace(/\//gu, '~s')
    .replace(/\\/gu, '~b')
    .replace(/</gu, '~l')
    .replace(/>/gu, '~g')
    .replace(/"/gu, "''")
    .replace(/\n/gu, '~n')
    .replace(/ /gu, '_')
  return encodeURIComponent(escaped)
}

async function getJson(target) {
  const res = await fetch(target, { signal: AbortSignal.timeout(30_000) })
  if (!res.ok) throw new Error(`memegen ${res.status}: ${target}`)
  return res.json()
}

function fail(message) {
  console.error(`Error: ${message}`)
  process.exit(1)
}
