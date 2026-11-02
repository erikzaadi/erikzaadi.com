#!/usr/bin/env node
// Generates one blog image with OpenAI (a text model drives the image_generation tool).
// --post gives the model the whole post as context, so the image fits its story and tone.
// Ported from https://github.com/erikzaadi/nerdalicous-presentation-skill (scripts/generate-slide-images.mjs)

import { access, mkdir, readFile, writeFile } from 'node:fs/promises'
import { dirname, extname, resolve } from 'node:path'
import { parseArgs } from 'node:util'

try {
  process.loadEnvFile('.env')
} catch (error) {
  if (error.code !== 'ENOENT') throw error
}

const { values: args } = parseArgs({
  options: {
    prompt: { type: 'string' },
    out: { type: 'string' },
    post: { type: 'string' },
    size: { type: 'string', default: '1536x864' },
    quality: { type: 'string', default: 'high' },
    style: { type: 'string', default: process.env.IMAGE_STYLE ?? '' },
    force: { type: 'boolean' },
    'dry-run': { type: 'boolean' },
  },
})

if (!args.prompt || !args.out) {
  fail('Usage: image.mjs --prompt "..." --out static/images/<post-slug>/<name>.png [--post content/posts/...md] [--size 1536x864] [--style "..."] [--dry-run] [--force]')
}
const format = { '.png': 'png', '.jpg': 'jpeg', '.jpeg': 'jpeg', '.webp': 'webp' }[extname(args.out).toLowerCase()]
if (!format) fail('--out must end in .png, .jpg or .webp')
if (!/^\d+x\d+$/u.test(args.size) || args.size.split('x').some((edge) => Number(edge) % 16)) {
  fail('--size must be WIDTHxHEIGHT with both edges divisible by 16, e.g. 1536x864')
}
const outPath = resolve(args.out)
if (!args.force && (await exists(outPath))) fail(`${args.out} exists (--force to regenerate)`)

const model = process.env.OPENAI_IMAGE_CONTEXT_MODEL ?? 'gpt-5.5'
const imageModel = process.env.OPENAI_IMAGE_MODEL ?? 'gpt-image-2.5-flare'
const post = args.post ? await readFile(resolve(args.post), 'utf8') : ''
const brief = [
  `Image prompt: ${args.prompt}`,
  'It is an illustration inside a blog post: no borders, frames, captions or watermarks.',
  'Keep any text the prompt asks for to a few short, correctly spelled words.',
  'No real company logos or brand marks.',
  args.style ? `Visual style: ${args.style}` : null,
]
  .filter(Boolean)
  .join('\n')
const content = [
  post && { type: 'input_text', text: `The blog post this image belongs to, for story and tone:\n\n${post}` },
  { type: 'input_text', text: brief },
].filter(Boolean)

console.log(`${model} → ${imageModel}, ${args.size}, quality ${args.quality}${post ? `, post context (${post.length} chars)` : ''}`)
if (args['dry-run']) {
  console.log(`\nWould write ${outPath} with this brief:\n\n${brief}`)
  process.exit(0)
}
if (!process.env.OPENAI_API_KEY) fail('OPENAI_API_KEY is not set (put it in .env at the repo root)')

const body = {
  model,
  input: [{ role: 'user', content }],
  tools: [{ type: 'image_generation', model: imageModel, action: 'generate', size: args.size, quality: args.quality, output_format: format }],
  tool_choice: { type: 'image_generation' },
}
const json = await withRetries(() => postJson('https://api.openai.com/v1/responses', body))
const result = json.output?.find((item) => item.type === 'image_generation_call')?.result
if (!result) fail('OpenAI API returned no image')
await mkdir(dirname(outPath), { recursive: true })
await writeFile(outPath, Buffer.from(result, 'base64'))
console.log(`Saved ${outPath}. Look at it before using it (spelling, odd details).`)

async function postJson(url, payload) {
  const response = await fetch(url, {
    method: 'POST',
    headers: { Authorization: `Bearer ${process.env.OPENAI_API_KEY}`, 'Content-Type': 'application/json' },
    body: JSON.stringify(payload),
    signal: AbortSignal.timeout(300_000), // high-quality images can take minutes
  })
  if (response.ok) return response.json()
  const text = await response.text()
  let detail = text
  try {
    detail = JSON.parse(text).error?.message ?? text
  } catch {
    // not JSON: keep the raw text
  }
  // other 4xx won't fix itself
  throw Object.assign(new Error(`OpenAI API ${response.status}: ${detail}`), {
    retryable: response.status >= 500 || response.status === 429,
  })
}

async function withRetries(attemptOnce) {
  for (let attempt = 1; ; attempt += 1) {
    try {
      return await attemptOnce()
    } catch (error) {
      if (error.retryable === false || attempt === 3) fail(error.message)
      console.log(`  ${error.message}\n  Retrying in ${2 ** attempt}s...`)
      await new Promise((done) => setTimeout(done, 1000 * 2 ** attempt))
    }
  }
}

async function exists(path) {
  return access(path).then(() => true, () => false)
}

function fail(message) {
  console.error(`Error: ${message}`)
  process.exit(1)
}
