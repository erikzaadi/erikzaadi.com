---
title: "Auto Resume Claude Code Sessions"
date: 2026-02-15T13:34:18+02:00
tags: ["AI", "Claude", "Productivity", "Automation"]
---

I'm a big user of Claude Code, their CLI is AMAZONG, you can even paste images of outputs and it'll parse it.

{{< paddedimage "/images/jcvd-terminal.png" "Claude Van Terminal" >}} 

Needless to say, I'm a heavy `tmux` user, and I usually have several sessions windows and pane open, with plentiful of Claude CLI sessions in place.

## The Problem

When exiting Claude Code, it shows a resume command, _BUT_, once the
terminal clears, it's gone. I wanted a way to automatically pick up
where I left off.

## The Solution

**Note:**

*You'll need `jq` for this to work. `zsh` is not mandatory, doing
something similar in `bash` is trivial.*

Two small pieces wired together:

### 1. A SessionEnd Hook (`~/.claude/settings.json`)

Claude Code supports hooks; shell commands that fire on lifecycle
events. I added a `SessionEnd` hook that writes the resume command to
`.claude_session` in the current working directory on every exit:

``` json
"hooks": {
  "SessionEnd": [
    {
      "matcher": "",
      "hooks": [
        {
          "type": "command",
          "command": "jq -r '\"echo \\\"claude --resume \" + .session_id + \"\\\" > \" + .cwd + \"/.claude_session\"' | sh"
        }
      ]
    }
  ]
}
```

### 2. A Shell Function (`c`)

A tiny `zsh` function that checks for the saved session file in the
current directory:

``` sh
c() {
  if [ -f .claude_session ]; then
    local cmd
    cmd=$(cat .claude_session)
    rm -f .claude_session
    eval "$cmd"
  else
    claude "$@"
  fi
}
```

## How It Works

-   Exit Claude Code -> the hook saves the session ID to
    `.claude_session`
-   Run `c` from the same directory -> it resumes right where you left
    off
-   Run `c` again (or with arguments) -> it starts a fresh session,
    since the file was consumed
-   Multiple projects = multiple sessions, no conflicts

Total time: about two minutes of Claude hacking. Now I only lose context in meetings.
