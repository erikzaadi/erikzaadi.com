---
title: "Onboarding vim'ers"
date: 2024-11-17T16:00:24+02:00
description: "Because people deserve to see the light"
tags: ['vim', 'neovim', 'terminal', 'productivity']
---

## Vim FTW

(Neo)Vim often seems daunting for people to start to work on.

The basic out of the box experience with Vim isn't very `vi improved` I'm afraid.

![](https://cdn.thenewstack.io/media/2022/08/0ae25624-exit-vim-the-arrival-way-6n632sipjag61-1024x692.jpg)

### But then they see me vim'in, the cravin'

Being one of the cool kids with vim, I'm often asked how people can get started with vim without all the classic exiting vim memes.

![](https://preview.redd.it/seriously-though-how-do-i-exit-vim-v0-mx7dxqljnnl81.png?auto=webp&s=03f895ee50952918687dfdfea03c0bc3af097754)

## A now hope arises

Recently, I had a chad at work ask me to get him started with vim!

![](https://i.imgflip.com/9anohj.jpg)

YAAY a new incoming convert I thought!

## Initial attempt

Having that my [dotFiles](https://github.com/erikzaadi/dotFiles) can be _ahem_ a bit over-engineered, I naively told him to try the following route:

1. Add a vim bindings plugin to his VsCode
2. Install [SpaceVim](https://spacevim.org/) for a quickstart
3. Get used to stuff
4. Roll his own config like a boss

The first step was fine, then we got to SpaceVim.

My days, after he showed me it (and it took a couple of seconds to load), I was instantly regretful of my actions.

I admit that I might be extremely opinionated about my vim defaults, but this experience with SpaceVim caused the exact opposite of what I wanted to achieve!

To be frank (I'd have to change my name), it backfired and the chad postponed his vim enlightenment! 

### THE HORROR!!1

So, going forward, I'm creating a simple 4 STEPS TO SUCCESS LADDER for on-boarding vim'ers:

1. Vim bindings in whatever blasphemy they call IDE
2. [Vimium](https://chromewebstore.google.com/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb?hl=en)
3. UBER simple native [vim configuration](https://github.com/erikzaadi/dotFiles/blob/master/vim/bare.vimrc) (just syntax highlight and spell check for git commits and markdown):

```vimrc
    set nocompatible              " be iMproved, required

    autocmd FileType markdown setlocal spell
    autocmd FileType gitcommit setlocal spell

    hi Normal guibg=NONE ctermbg=NONE
    hi Pmenu guibg=NONE ctermbg=NONE
    filetype plugin indent on
    if !exists("g:syntax_on")
        syntax enable
    endif
```

4. Basic [NeoVim config](https://github.com/erikzaadi/dotFiles/blob/master/nvim/beginner.lua) which allows simple code navigation and completion

## Try it out!

![](https://i.giphy.com/media/v1.Y2lkPTc5MGI3NjExYWZrc3p6YnBpZTFxam50emc4ZTV1NWloYTlpOW1oOGl0N2gyNXFwaSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/IL4iTvQH0MjS/giphy.gif)
