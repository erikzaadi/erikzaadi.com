---
date: 2017-06-19T14:12:14+03:00
description: "TMUX MÖDIFIER FTL, or simply detecting current input language from terminal"
title: "TMUX for multilangual cli addicts"
categories: [TMUX, cli, Swedish, Mac]
---

## As you might know, TMUX is awesome.

### ALAS

There is nothing more frustrating than when you're muscle memory fails you.

You're entering the correct key sequence, and your `tmux` is simply ignoring you.

You enter a state of **CLI ROAD RAGE**.

![](/images/road-rage-phone.gif)

You curse the old gods of QUERTY, check your keyboard battery level (_/hipster_), gurgle quotes such as:

> That wouldn't happen in linux

Only to discover a couple of minutes later that your input language was in Swedish.

### Now TMUX may be smart

But there's no way in hell that `tmux` will recognize your _MÖDIFIER_ instead of _MODIFIER_.

### Applescript to the rescue

[StackOverflow](https://stackoverflow.com/questions/21597804/determine-os-x-keyboard-layout-input-source-in-the-terminal-a-script) brought me a lovely snippet in Applescript that get's the current language.

I saved that with an Applescript shebang (`#!/usr/bin/env osascript`) as an executable in my path called `apple-language`. See [here](https://github.com/erikzaadi/dotFiles/blob/master/bin-mac/apple-language) for reference.

But showing the current languange in TMUX as an indicator is lame, let's do it with emoji!!1

Enter [apple-languange-to-emoji](https://github.com/erikzaadi/dotFiles/blob/master/bin-mac/apple-language-to-emoji)!!1

Ok now I have the current language flag emoji, now for making that visible in TMUX, I simple add `#(apple-language-to-emoji)` in my status bar.

Here's the entire [change](https://github.com/erikzaadi/dotFiles/commit/b2b3cfd444e1ca56950ec013b0be6f846d406a6e).

Unt Voila!
