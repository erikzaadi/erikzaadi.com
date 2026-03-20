# Claude Code Notes

## Dev server
The Hugo dev server is usually already running during sessions. No need to start it or run hugo commands to preview changes.

## New posts
Use `./new_post.sh "Post Title"` to create a new post. It creates the file under `content/posts/<year>/<slug>.md` and prints the path.

## Linking between posts
Use relative paths (e.g. `/2026/03/08/post-slug/`) when linking between posts, not full URLs. This ensures links work both in local dev and in the preview deployment flow.

## Writing style
- No em dashes (—) or en dashes (–). Use commas, colons, or short sentences instead.
