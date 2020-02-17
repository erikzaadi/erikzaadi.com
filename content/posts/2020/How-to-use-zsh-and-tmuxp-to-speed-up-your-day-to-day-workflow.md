---
title: "How to Use Zsh and Tmuxp to Speed Up Your Day to Day Workflow"
date: 2020-02-17T18:44:46+02:00
description: "Again TUI to the rescue"
tags: ['tmux', 'zsh', 'vim', 'terminal', 'productivity']
---

# I'm a heavy terminal user.

![](https://media.giphy.com/media/W1ecIq4sEofza/giphy.gif)

## I admit it.

I've always loved the streamlined workflows of elegant TUI (AKA TEXT USER INTERFACE FTW).

### It's one of the things that made me switch to `vim` all those years ago.

In addition, I'm addicted to `tmux` and `zsh`, which I use daily.

## Anyhuze

In my day to day job, I continuously need to switch between several applications that I might work on, some of them in separate repositories, some even in a monorepo (!).

### To make this more productive, I use the following flow:

I have preconfigured [tmuxp](http://tmuxp.git-pull.com/en/latest/) sessions as following:

`standaloneapp.yml`

```yaml
---
session_name: "${APP}"
shell_command_before: "nvm use ${NODE_VERSION:-default}"
start_directory: "${WORKSOURCEDIR}/${APP}"
windows:
  - panes:
      - vim
    window_name: editor
  - panes:
      - git status
    window_name: shell
  - layout: even-horizontal
    panes:
      - yarn test --watch
    window_name: tests
```

and `monorepoapp.yml`
```yaml
---
session_name: "${APP}"
shell_command_before: "nvm use ${NODE_VERSION:-default}"
start_directory: "${WORKSOURCEDIR}/mymonorepo/packages/${APP}"
windows:
  - panes:
      - vim
    window_name: editor
  - panes:
      - git status
    window_name: shell
  - layout: even-horizontal
    panes:
      - yarn test --watch
    window_name: tests
```

Which I can invoke with a simple

```sh
APP=myapp tmuxp load standaloneapp
# or
APP=mypackage tmuxp load monorepoapp
# or if with a special node version
APP=myapp NODE_VERSION=v12 tmuxp load standaloneapp
```

### To improve this even MOAR:

I have the following `zsh` aliases to shorten things:

```zsh
alias ms="tmuxp load -y"
wo()
{
    APP=$1 NODE_VERSION=${2:-default} ms standaloneapp
}

mwo(){
    APP=$1 NODE_VERSION=${2:-default} ms monorepoapp
}
```

Which allows me to do just:

```sh
wo myapp
# or 
mwo mypackage
# or for that special node version app
wo myapp v12
```

## AND FINALLY

How could we possibly get along without some sweet tab completions?

```zsh
compdef '_path_files -/ -W ${WORKSOURCEDIR}/mymonorepo/packages' mwo
compdef '_path_files -/ -W ${WORKSOURCEDIR}' wo
```

_mic drop_
