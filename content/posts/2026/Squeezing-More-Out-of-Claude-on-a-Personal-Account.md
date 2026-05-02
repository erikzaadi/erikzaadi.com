---
title: "Squeezing More Out of Claude on a Personal Account"
date: 2026-05-02T10:00:00+03:00
tags: ["claude", "ai", "productivity", "dnd", "tools"]
description: "Practical optimizations I made while using Claude Code on a personal account to keep developing dnd-fam-ftw."
toc: false
image: /images/claude-neovim-savings/claude-savings-for-dnd.png
---

After [building dnd-fam-ftw](/2026/04/08/my-kid-didnt-want-to-dm-so-i-built-one/), I kept hacking on it using Claude Code on my personal account. Personal accounts have usage limits, so I started paying attention to where tokens were going and where they weren't. Here's what actually helped.

{{< paddedimage "/images/claude-neovim-savings/claude-savings-for-dnd.png" "Small change that brought efficiency" >}}

---

## CLAUDE.md as a Memory Workaround

Claude Code compacts context automatically when it gets long. When that happens, it relies on `CLAUDE.md` to rebuild its understanding of the project. If your `CLAUDE.md` is thin, you pay in repeated re-explanation and mistakes after each compaction. If it's _THICCC_, you pay in time and tokens each time you start a new session (ironically when you run `/clean` to save tokens as well).

I treat `CLAUDE.md` as the answer to: "what would a new engineer need to know before touching this codebase?" It's not docs, it's orientation. Architecture decisions, non-obvious conventions, gotchas, script commands. Anything I'd have to explain from scratch after a context reset goes in there, classing `CONTRIBUTING.md` style information.

The payoff is that after compaction Claude picks up close to where it left off without me needing to re-explain things.

---

## .claudeignore

`.claudeignore` works like `.gitignore` but tells Claude Code what not to read. In dnd-fam-ftw this meant ignoring:

```
node_modules/
frontend/dist/
backend/dist/
terraform/.terraform/
frontend/src/test/snapshots/
package-lock.json
temp/
next-up-instructions/
previous-md-instructions/
```

Before I added this, Claude would sometimes pull in thousands of lines of generated or vendored code when trying to understand the project. That burned context fast and didn't help.

The rule I follow: if you wouldn't code-review it, ignore it.

---

## Explicit Permissions in settings.json

Every time Claude Code wants to run a command it hasn't seen before, it prompts you. This is safe behavior, but the interruptions add up. I went through my sessions and explicitly allowed the commands I trust:

```json
{
  "permissions": {
    "allow": [
      "Bash(npm run *)",
      "Bash(git status)",
      "Bash(git diff *)",
      "Bash(git log *)",
      "Bash(find * -name *)",
      "Bash(cat *)"
    ]
  }
}
```

The pattern `Bash(npm run *)` covers all npm scripts without being a blanket allow-all. I kept destructive things (`git push`, `git reset`) out of the list so they still prompt.

Less friction, same safety where it matters.

---

## Shell Setup for Resuming Sessions

Claude Code supports `--resume <session-id>` to pick up where you left off. Rather than copy-pasting session IDs, I set up a `c` shell function that handles this automatically.

Yes, this is the one from [my previous blog post](/2026/02/15/auto-resume-claude-code-sessions/), but with some fixes and improvements.

The trick is a `.claude_session` file in the project root (gitignored, also in `.claudeignore`). A `SessionEnd` hook writes the resume command to that file when the session ends. The hook skips sub-agent sessions (those have an `agent-` prefix on the session ID) so only the top-level session gets saved. It also resolves the git root, so the file always lands at the repo root regardless of which subdirectory you ran Claude from.

```json
{
  "hooks": {
    "SessionEnd": [{
      "matcher": "",
      "hooks": [{
        "type": "command",
        "command": "data=$(cat); session_id=$(printf '%s' \"$data\" | jq -r '.session_id'); cwd=$(printf '%s' \"$data\" | jq -r '.cwd'); if [ \"${session_id#agent-}\" = \"$session_id\" ]; then git_root=$(git -C \"$cwd\" rev-parse --show-toplevel 2>/dev/null || echo \"$cwd\"); echo \"claude --resume $session_id\" > \"$git_root/.claude_session\"; fi"
      }]
    }]
  }
}
```

When you call `c` again, it reads the file, checks that the session file still exists on disk, and resumes it if so. If the session is gone, it cleans up and starts fresh.

```zsh
c () {
  if [ -f .claude_session ]; then
    local cmd session_id session_file
    cmd=$(cat .claude_session)
    session_id=$(echo "$cmd" | sed -n 's/.*--resume[[:space:]]\+\([^ ]*\).*/\1/p')
    if [ -n "$session_id" ]; then
      session_file="${CLAUDE_CONFIG_DIR:-$HOME/.claude}/projects/$(pwd | sed 's/[^a-zA-Z0-9]/-/g')/$session_id.jsonl"
      if [ -f "$session_file" ]; then
        rm -f .claude_session
        eval "$cmd"
        return
      fi
    fi
    rm -f .claude_session
  fi
  claude "$@"
}
```

For the personal account, one more alias on top:

```zsh
alias claude-personal="CLAUDE_CONFIG_DIR=~/.claude-personal c"
```

`CLAUDE_CONFIG_DIR` points Claude at a separate config directory, so personal account sessions, settings, and memory are completely separate from the work account. `claude-personal` in a project dir picks up the last personal session for that project, or starts fresh if there isn't one.

---

## Neovim Integration Modes

I use [claudecode.nvim](https://github.com/coder/claudecode.nvim) to connect Neovim to Claude Code. There are two ways to run this setup, and I'm still settling on which one I prefer.

**The separate panes mode** is what I use day to day. Claude Code CLI runs in one tmux pane, Neovim in another. Running `/ide` in Claude Code connects them via MCP, so Claude can read open buffers and diagnostics without me pasting anything manually.

One snag: claudecode.nvim defaults to a single MCP connection. If you run multiple Claude sessions across different projects, they collide. I [forked](https://github.com/coder/claudecode.nvim/pull/247) the plugin to include the working directory (and optionally the tmux window/pane) in the connection name, so each session gets a unique identifier and the right Claude instance picks it up.

{{< paddedimage "/images/claude-neovim-savings/select-neovim-tmux-ide.png" "Small change that brought efficiency" >}}

I keep coming back to this mode because it fits how I already work. tmux buffer search is something I rely on: I can scroll back through everything Claude output, copy a command it suggested three exchanges ago, or check what it reasoned through. That history just lives in the terminal.

**The embedded mode** runs Claude Code directly inside Neovim through the same plugin, no separate pane needed. It's cleaner in theory, fewer windows to manage. But it feels a bit IDE-ish, which sits slightly wrong for how I think about my editor. I'm still experimenting with it, no verdict yet.

---

## Steering Sub-Agent Model Choice

There's no setting for this, but you can just ask. Claude Code spins up sub-agents for parallelizable work, and by default they use the same model as the main session. For simple tasks like `find`, `git grep`, `ls`, or `cat`, that's overkill.

Adding a note to `CLAUDE.md` asking Claude to use a simpler model for sub-agents doing basic file operations cuts those costs noticeably. It won't always comply perfectly, but it follows the instruction often enough to matter on a personal account where every token counts.

---

## What Made the Biggest Difference

Ranked by actual impact:

1. **CLAUDE.md** - post-compaction quality went up significantly
2. **Session resume** - getting back into flow without re-explaining context
3. **.claudeignore** - mostly relevant for projects with large generated files
4. **Explicit permissions** - nice quality of life, fewer interruptions

None of this is magic. It's just removing friction between you and the tool so more of your time goes into building.

---

dnd-fam-ftw code is at [github.com/erikzaadi/dnd-fam-ftw](https://github.com/erikzaadi/dnd-fam-ftw) if you want to see the project this grew out of.
