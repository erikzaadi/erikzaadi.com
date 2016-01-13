---
layout: post
title: "auto installing vundle from your vimrc"
date: 2012-03-19
comments: true
categories: [vim, vundle]
---

### You should be using vundle
[Vundle](https://github.com/VundleVim/Vundle.vim) is a vim plugin manager, ala [pathogen](https://github.com/tpope/vim-pathogen/).

Vundle allows you to specify in your `vimrc` what vim plugins you wish to load, and it'll automatically download (git clone if possible) and enable vim plugins. 

Vundle can get a name of a plugin as it appears in the vim plugin directory, a github `:user/:repo` style string, and even a full git url.

```
Plugin 'Syntastic' "uber awesome syntax and errors highlighter
Plugin 'altercation/vim-colors-solarized' "T-H-E colorscheme
Plugin 'https://github.com/tpope/vim-fugitive' "So awesome, it should be illegal 
```

Vundle also updates your vim plugins with a simple command :
```
:VundleUpdate
```

Vundle is awesome, it saves a lot of the manual work needed in [pathogen](https://github.com/tpope/vim-pathogen).

Even more if your installing your vim plugins manually, oy vei.

However, there's always the fuss of getting it installed on a fresh machine.
Adding these lines to your `.vimrc`, fixes that : 

```
" Setting up Vundle - the vim plugin bundler
    let iCanHazVundle=1
    let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
    if !filereadable(vundle_readme) 
        echo "Installing Vundle.."
        echo ""
        silent !mkdir -p ~/.vim/bundle
        silent !git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/vundle
        let iCanHazVundle=0
    endif
    set nocompatible              " be iMproved, required
    filetype off                  " required
    set rtp+=~/.vim/bundle/vundle/
    call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'
    "Add your bundles here
    Plugin 'Syntastic' "uber awesome syntax and errors highlighter
    Plugin 'altercation/vim-colors-solarized' "T-H-E colorscheme
    Plugin 'https://github.com/tpope/vim-fugitive' "So awesome, it should be illegal 
    "...All your other bundles...
    if iCanHazVundle == 0
        echo "Installing Vundles, please ignore key map error messages"
        echo ""
        :PluginInstall
    endif

    call vundle#end() 
    "must be last
    filetype plugin indent on " load filetype plugins/indent settings
    colorscheme solarized
    syntax on                      " enable syntax
 
" Setting up Vundle - the vim plugin bundler end
```

This will clone vundle and activate it, and install all your bundles (if vundle is not installed).

#### Disclaimer : Works on my machine ;)
This should work on any \*nix machine, although windows 7 should cope with it too (not tested lately)

### Enjoy!
