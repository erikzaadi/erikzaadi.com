---
date: 2017-02-18T14:58:59+02:00
description: "Because not only Leonardo should enjoy (TMUX) inception"
title: "Make remote tmux sane with a keystroke"
categories: ['tmux', 'cli', 'hack']

---

### Prelude

It's 2 am. You're ssh'ing to a server.

Naturally you launch `tmux`.

!['hacker time'](/images/hackerman-time.gif)

You run some `tail -f` on some logs, each in it's own pane of course.

You try to reproduce something, and then you want to search for it at the logs.

### ALAS

The `tmux` defaults for copy mode and status keys are not `vi`.

!['Whyyy'](/images/why.jpg)

### The horror!

The only thing crappier than that is my memory, because I _NEVER_ remember the syntax for setting it.

Finally, I decided to stop the madness.

My `~/.tmux.conf` now has the following:

```bash
bind F3 send-keys 'tmux set -g mode-keys vi;tmux set -g status-keys vi' Enter
```

### BADA-BIM-BADA-BOOM

One keystroke away and any remote `tmux` I visit in whatever `tmux` inception scenario, I have my previous `vi` bindings.

!['Hackerman power up'](/images/hackerman-transformation.gif)

Yours truly, Erik, a `tmux` addict.
