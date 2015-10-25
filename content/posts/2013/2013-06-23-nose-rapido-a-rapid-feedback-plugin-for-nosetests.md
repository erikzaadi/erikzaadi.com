---
layout: post
title: "nose-rapido - a rapid feedback plugin for nosetests"
date: 2013-06-23
comments: true
categories: [nose, python, tdd, terminal, tmux]
---

I use a tmux + vim development environment which I find really productive.
When hacking on python projects, I like to have a tmux window open with nosetests logs, typically using [nose-watch](https://github.com/lukaszb/nose-watch).

Every now and then after saving, I'd switch to that window to see how the tests are doing.

I wanted something a bit more small that would give me immediate feedback in my main window that I use, which is of course the vim window.
The feedback should on one hand not take up to much screen estate, nor disrupt my vim-fu focus.

Enter [nose-rapido](https://github.com/erikzaadi/nose-rapido).

nose-rapido is a nosetests plugin, that does one small and simply thingy:
It fills your terminal with green (or optionally blue for the colorblinded) or red color, according to your nosetests result.

Install

```
pip install nose-rapido
```

Run

```
nosetests --with-rapido
```

With `nose-watch`

```
nosetests --with-rapido --with-watch
```

With blue colors instead of green

```
nosetests --with-rapido --rapido-blue
```

E.g:

![Tests passing](https://github.com/erikzaadi/nose-rapido/raw/master/screenshots/good.png)

And if you fail your tests:

![Tests failing](https://github.com/erikzaadi/nose-rapido/raw/master/screenshots/bad.png)

With blue instead of green:

![Tests success with blue](https://github.com/erikzaadi/nose-rapido/raw/master/screenshots/blue.png)

Enjoy!
