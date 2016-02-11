---
date: 2016-02-11T15:42:44+02:00
description: "Managing your vim plugins better"
title: Moving from Vundle to Vim-Plug
categories: ['vim', 'vundle', 'vim-plug']
---

I've been using [Vundle](https://github.com/VundleVim/Vundle.vim) to manage my vim plugins for quite a while now, even blogged about [auto installing](/2012/03/19/auto-installing-vundle-from-your-vimrc/) Vundle on new machines.

Vundle is still great, but I've been hearing a lot about [Vim-Plug](https://github.com/junegunn/vim-plug), which aims to be better than Vundle.

I opened up the [Vim-Plug Migration FAQ](https://github.com/junegunn/vim-plug/wiki/faq#migrating-from-other-plugin-managers), and gave it a try.

My initial impression was, WOW, that's fast, and much less clutter in my `.vimrc`.

No need for manual hacking around auto installing, it's baked in.

Then I discovered about [on demand loading of plugins](https://github.com/junegunn/vim-plug#on-demand-loading-of-plugins), which is a neat feature that allows you to determine when to load vim-plugins. This made my day to day experience with `vim` even faster!

This simply is a killer feature:

```
Plug 'scrooloose/nerdtree', { 'on':  ['NERDTreeToggle', 'NERDTreeFind'] } "Loads only when opening NERDTree
Plug 'fatih/vim-go', { 'for' : ['go', 'markdown'] } "Loads only when editing golang files
```

There are also post install hooks:

```
Plug 'Valloric/YouCompleteMe', { 'do' : '~/.vim/plugged/YouCompleteMe/install.py --gocode-completer --tern-completer' }
Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh', 'for' : ['go', 'markdown'] }
```

**EPIC!**

See [Github Diff](https://github.com/erikzaadi/dotFiles/compare/5b842d0798c2e1daf31a3cbc63a50362d715e61b...master#diff-2152fa38b4d8bb10c75d6339a959650d) for the actual migration, bare in mind that I took the opportunity to clean up my `.vimrc`, well a bit at least.
