---
name: blog-media
description: Add images, GIFs and memes to erikzaadi.com blog posts. Use when a post needs an illustration (OpenAI image generation), a reaction GIF (Giphy search and download) or a meme (memegen.link).
---

# Blog media

Three scripts in `.claude/skills/blog-media/scripts/`. Run them from the repo root: they read keys from the gitignored `.env` there (`OPENAI_API_KEY`, `GIPHY_API_KEY`). Memes need no key.

Save every file under `static/images/<post-slug>/` and embed it in the post with:

```
{{< paddedimage "/images/<post-slug>/<name>.png" "Alt text" >}}
```

Use kebab-case file names. Alt text follows the writing style in `CLAUDE.md` (no em or en dashes).

## Generated images (paid)

```sh
node .claude/skills/blog-media/scripts/image.mjs \
  --prompt "a rat in pipe-insulation armor, flat 3D cartoon" \
  --out static/images/<post-slug>/<name>.png \
  --post content/posts/<year>/<post>.md
```

- Each call costs money. Generate only images the user asked for, and run `--dry-run` first when the prompt is your own idea.
- `--post` sends the whole post as context so the image matches its story. Leave it out for a generic image.
- Default size is `1536x864` (16:9). `--size` takes any `WxH` divisible by 16. `--style` (or `IMAGE_STYLE` in `.env`) sets a look.
- Existing files are skipped; `--force` regenerates.
- Models: `OPENAI_IMAGE_CONTEXT_MODEL` (default `gpt-5.5`) and `OPENAI_IMAGE_MODEL` (default `gpt-image-2.5-flare`) in `.env`. Point them at replacements when OpenAI retires one.
- Show the user the result before inserting it: check on-image spelling and odd details.

## GIFs

```sh
node .claude/skills/blog-media/scripts/gifs.mjs search "this is fine dog" [--limit 8] [--rating pg-13]
node .claude/skills/blog-media/scripts/gifs.mjs download <id or giphy URL> static/images/<post-slug>/<name>.gif
```

Picking a GIF takes taste: show the user the candidates (id, title and giphy.com link) and let them pick. Search queries are cut to 50 characters, so keep them short. Prefer smaller files; a GIF over ~5 MB slows the page.

## Memes

```sh
node .claude/skills/blog-media/scripts/meme.mjs --templates drake
node .claude/skills/blog-media/scripts/meme.mjs drake static/images/<post-slug>/<name>.png "top line" "bottom line"
```

Search the template id first and give it as many lines as it has. Look at the result: the text fits and the joke still lands.
