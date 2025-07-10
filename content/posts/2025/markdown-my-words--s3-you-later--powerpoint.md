---
title: "Markdown My Words! S3 You Later PowerPoint"
date: 2025-07-10T14:21:52+03:00
description: "Building, editing, and deploying slide decks with nothing but Markdown, Bash, and dad puns."
author: "Erik Zaadi"
tags: ["slidev", "presentations", "bash", "automation", "markdown", "developer-tools"]
---

# Markdown is life

## So why not use it for presentations?

I do a fair bit of internal presentations, and like most good things, they’re powered by Markdown, duct tape, and a sprinkle of automation magic.

For a long time, I was using [reveal-md](https://github.com/webpro/reveal-md) for all my slides. But once that got deprecated, I moved to the absolutely AMAZONG [Slidev (sli.dev)](https://sli.dev) project.

It's markdown-first, extensible, and works brilliantly with my workflow.

Slidev is a simple as separating slides with `---` and just good old markdown:

```markdown

# ZOMG

## My subtitle

[Mandatory gif](https://media.giphy.com/media/11RgbBSgomKx6o/giphy.gif)

<b>Whatever custom html I want as well</b>

---

Second slide FTW

```

With some superb advanced features like layouts, animations and MOAR.

```markdown

# ZOMG

## My subtitle

---
layout: image-right
image: https://media.giphy.com/media/11RgbBSgomKx6o/giphy.gif
backgroundSize: contain
---

Second slide with image on the right

```

### Why is this interesting you ask?

![](https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExNW5jZjN2ZnNsNjBibmh6NGw0cHYzb3hqbGFhb3ducmhoZTJyMnB3NyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/WhTC5v5qQP4yAUvGKz/giphy.gif)

This allows for a rapid feedback iterative work on your presentation.

Crank out your story fast, then re-iterate with puns gifs and memes.

---

## 🛠️ Bootstrapping Presentations Like a Procrastination-Driven Pro

Creating a presentation from scratch every time? 

![](https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExM2tndHMyb21hMmNoZXd5MHltOXQ5NHY4M2Foa3Rwemw3NTlxdW1nNyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/xdLH51eNWZAHrwy5mf/giphy.gif)

I’ve automated the whole process so I can go from “Oh, I should present this” to “Slides are up!” in seconds.

It starts with a little shell function:

```zsh
pwo () {
    PRESENTATION_NAME="$*" tmuxp load -y presentation
}

# Auto complete existing presentations
compdef '_path_files -/ -W ${PRESENTATIONDIR}' pwo
```

This spins up a [`tmuxp`](https://github.com/tmux-python/tmuxp) session defined like so:

```yaml
# ~/.config/tmuxp/presentation.yaml
session_name: "El Presento - ${PRESENTATION_NAME}"
windows:
  - panes:
      - cd $(init-presentation ${PRESENTATION_NAME}); ${EDITOR} ./presentation.md
    window_name: editor
  - panes:
      - cd $(init-presentation ${PRESENTATION_NAME}); slidev --open ./presentation.md
    window_name: slidev
```

Why _El Presento_? Because it was a pun I thought of when spinning up this script and it stuck ;)

![](https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExYTM4MGpwN24zYmFxMHowNGcwa3kzZnY2NWg0Mzhrenl0YjVhZzBxeiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/26ufc0OsEUTWhDw0E/giphy.gif)

---

## 🧙 The `init-presentation` script

This script does a lot (EVEN ALOT):
- Slugifies the presentation name
- Creates the directory
- Writes the initial `presentation.md` with Slidev frontmatter
- Adds image assets and an HTML file for local fallback

It expects there to be a template folder with my avatar, base template and snippets.

```bash
#!/usr/bin/env bash
PRESENTATION_NAME="$*"
PRESENTATION_NAME_FORMATTED="$(echo "${PRESENTATION_NAME}" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')"
PRESENTATION_FINAL_DIR="${PRESENTATIONDIR}/${PRESENTATION_NAME_FORMATTED}"
PRESENTATION_TEMPLATE_DIR="${PRESENTATIONDIR}/template"

TEMPLATE="""---
author: Erik Zaadi
browserExporter: false
contextMenu: false
download: false
favicon: './images/avatar.png'
mdc: true
monaco: false
monacoTypesSource: none
presenter: false
record: false
routerMode: hash
title: ${PRESENTATION_NAME}
titleTemplate: '%s'
drawings:
  enabled: false

defaults:
  transition: slide-left
  layout: center
---

## ${PRESENTATION_NAME}

#### FTW!

----

Here be dragons!

---
src: ../template/fin.md
---
"""

if [[ ! -d "${PRESENTATION_FINAL_DIR}" ]]; then
    mkdir -p "${PRESENTATION_FINAL_DIR}/images" > /dev/null
    echo "${TEMPLATE}" > "${PRESENTATION_FINAL_DIR}/presentation.md"
    ln "${PRESENTATION_TEMPLATE_DIR}/index.html" "${PRESENTATION_FINAL_DIR}/index.html"
    ln "${PRESENTATION_TEMPLATE_DIR}/avatar-512.png" "${PRESENTATION_FINAL_DIR}/images/avatar.png"
fi

echo "${PRESENTATION_FINAL_DIR}"
```

Basically: run `pwo 'My Awesome Topic'`, and I'm in a Slidev editing session with `nvim` and live preview.

![](https://media1.tenor.com/m/FuEJnJTyjqoAAAAC/like-a-sir-only-lulz-can-understand.gif)

---

## 🌍 Deploying slides (FTW)

No workflow is complete without CI/CD — even for slides.

![](https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExMG53Nmd2d3U3MWpuYnpuYW1lbTZ1cjAwcWFpd2NvbHc4ZjVobGkwMCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/Pvuf56bWDuEP6/giphy.gif)

I host all my slides at AWS (a S3 bucket behind a cloudfront distribution for ssl).

Here's my `slidev-deploy` script:

```bash
#!/usr/bin/env bash
PRESENTATION=${1:-'presentation.md'}
CURR_DIR=$(basename "${PWD}" | tr '[:upper:]' '[:lower:]')
# Expects AWS_PROFILE=SOMETHING_SUPER_SECRET
ZE_BUCKET=slides.erikzaadi.com
ZE_CLOUDFRONT_ID=SOMETHING_GUID_ISH
rm -rf ./dist > /dev/null
slidev build --base "/${CURR_DIR}/" "${PWD}/${PRESENTATION}"
aws s3 sync --follow-symlinks --acl public-read ./dist "s3://${ZE_BUCKET}/${CURR_DIR}/"
if [[ -d ./images ]]; then
    aws s3 cp --recursive --acl public-read ./images "s3://${ZE_BUCKET}/${CURR_DIR}/images/"
fi
# create cloudfront invalidation in case it's re-deployed
aws cloudfront create-invalidation --distribution-id "${ZE_CLOUDFRONT_ID}" --paths "/${CURR_DIR}/*" | jq '.Invalidation | .Status'
open "https://${ZE_BUCKET}/${CURR_DIR}/?random=${RANDOM}" # random as a quick cache buster
```

It:
- Builds the Slidev presentation
- Uploads to an S3 bucket
- Invalidates the CloudFront cache
- Opens it in my browser, because why not

---

## 🐉 Slides Should Be Punny

After all the setup is done, I finally get to the real work: 
- Adding way too many puns (can that even be a thing?!?!?!)
- Including way too many GIFs (MOAAAR) 
- And probably one meme too many (NEVAH)

If it doesn’t make people laugh and learn at the same time, I’m not doing it right.

![](https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExdGcwbmZpYm9qM3ozZDBwNzU2OXg1bzFtMmVmZWxkNDN3N3NxeWVvcSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/OQnAhtvxYr7AFVOG27/giphy.gif)

---

## 💭 TL;DR

- I use [Slidev](https://sli.dev) for all internal presentations  
- Everything’s markdown-first  
- Automated setup with `tmuxp` and shell scripts  
- Deploys to [slides.erikzaadi.com](https://erikzaadi.com/slides)
- Powered by caffeine and dad jokes

![](https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExN2c5dHplajRrNTR6Y2cwM2dycWpiZXQwODlsbTNvejJyd3h1amdyNyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/bKnEnd65zqxfq/giphy.gif)
