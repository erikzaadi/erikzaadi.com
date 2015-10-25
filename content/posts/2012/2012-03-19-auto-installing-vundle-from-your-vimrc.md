---
layout: post
title: "auto installing vundle from your vimrc"
date: 2012-03-19
comments: true
categories: 
---

### You should be using vundle
[Vundle](https://github.com/gmarik/vundle) is a vim plugin manager, ala [pathogen](https://github.com/tpope/vim-pathogen/).

Vundle allows you to specify in your vimrc what vim plugins you wish to load, and it'll automatically download (git clone if possible) and enable vim plugins. 

Vundle can get a name of a plugin as it appears in the vim plugin directory, a github `:user/:repo` style string, and even a full git url.

```
Bundle 'Syntastic' "uber awesome syntax and errors highlighter
Bundle 'altercation/vim-colors-solarized' "T-H-E colorscheme
Bundle 'https://github.com/tpope/vim-fugitive' "So awesome, it should be illegal 
```

Vundle also updates your vim plugins with a simple command :
```
:BundleInstall!
```

Vundle is awesome, it saves a lot of the manual work needed in [pathogen](https://github.com/tpope/vim-pathogen).

Even more if your installing your vim plugins manually, oy vei.

However, there's always the fuss of getting it installed on a fresh machine.
Adding these lines to your .vimrc, fixes that : 

```
    " Setting up Vundle - the vim plugin bundler
        let iCanHazVundle=1
        let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
        if !filereadable(vundle_readme) 
            echo "Installing Vundle.."
            echo ""
            silent !mkdir -p ~/.vim/bundle
            silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
            let iCanHazVundle=0
        endif
        set rtp+=~/.vim/bundle/vundle/
        call vundle#rc()
        Bundle 'gmarik/vundle'
        "Add your bundles here
        Bundle 'Syntastic' "uber awesome syntax and errors highlighter
        Bundle 'altercation/vim-colors-solarized' "T-H-E colorscheme
        Bundle 'https://github.com/tpope/vim-fugitive' "So awesome, it should be illegal 
        "...All your other bundles...
        if iCanHazVundle == 0
            echo "Installing Bundles, please ignore key map error messages"
            echo ""
            :BundleInstall
        endif
    " Setting up Vundle - the vim plugin bundler end
```

This will clone vundle and activate it, and install all your bundles (if vundle is not installed).

#### Disclaimer : Works on my machine ;)
This should work on any \*nix machine, although windows 7 should cope with it too (not tested lately)

### Enjoy!
