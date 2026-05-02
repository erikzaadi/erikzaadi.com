# Claude Code Notes

## Dev server
The Hugo dev server is usually already running during sessions. No need to start it or run hugo commands to preview changes.

## New posts
Use `./new_post.sh "Post Title"` to create a new post. It creates the file under `content/posts/<year>/<slug>.md` and prints the path.

## Linking between posts
Use relative paths (e.g. `/2026/03/08/post-slug/`) when linking between posts, not full URLs. This ensures links work both in local dev and in the preview deployment flow.

## Post front matter
When creating or editing posts, use these fields:
```yaml
---
title: "Post Title"
date: 2026-05-02T10:00:00+03:00
tags: ["tag1", "tag2"]
description: "Short description for OG/SEO"
draft: true
# optional:
toc: false        # disable table of contents
image: "/path"    # OG/thumbnail image
---
```

## Shortcodes
Custom shortcodes available in `layouts/shortcodes/`:
- `{{< paddedimage "/path" "Alt Text" >}}` — image with rounded corners and shadow (optional 3rd arg: width, default 80%)
- `{{< centerimage "/path" "Alt Text" >}}` — centered image
- `{{< speakerdeck "id" >}}` — embeds a SpeakerDeck presentation

## Draft workflow
Run `./open_drafts.sh` to open all posts with `draft: true` in `$EDITOR` (split windows).

## Preview deployment
Push to the `preview` branch to deploy a draft-inclusive build to `blogpreview.erikzaadi.com`. The `master` branch deploys to `erikzaadi.com` (no drafts).

## Writing style
- No em dashes (—) or en dashes (–). Use commas, colons, or short sentences instead.
