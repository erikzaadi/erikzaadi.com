---
date: '2011-07-11'
layout: post
slug: making-the-touchpad-work-with-two-finger-swipes-on-ubuntu-10-10-installed-on-a-lenovo-laptop
status: publish
title: Making the touchpad work with two finger swipes on ubuntu 10.10 installed on
  a Lenovo laptop
wordpress_id: '319'
comments: true
categories:
- Install
- IT
tags:
- lenovo
- synaptics
- touchpad
- ubuntu
---

Once you've tried a mac, it's hard to use a touchpad without multitouch capabilities.

On Ubuntu 11.04 this should work out of the box, but the script below will allow you to control the settings better than the UI.

Save this script somewhere on your disk:

```bash
#!/bin/sh
sleep 10
xinput --set-prop --type=int --format=32 "SynPS/2 Synaptics TouchPad" "Synaptics Two-Finger Pressure" 4
xinput --set-prop --type=int --format=32 "SynPS/2 Synaptics TouchPad" "Synaptics Two-Finger Width" 8 # Below width 1 finger touch, above width simulate 2 finger touch. - value=pad-pixels
xinput --set-prop --type=int --format=8 "SynPS/2 Synaptics TouchPad" "Synaptics Two-Finger Scrolling" 1 1 # vertical scrolling, horizontal scrolling - values: 0=disable 1=enable
xinput --set-prop --type=int --format=8 "SynPS/2 Synaptics TouchPad" "Synaptics Edge Scrolling" 0 0 0 # vertical, horizontal, corner - values: 0=disable 1=enable
xinput --set-prop --type=int --format=32 "SynPS/2 Synaptics TouchPad" "Synaptics Jumpy Cursor Threshold" 250 # stabilize 2 finger actions - value=pad-pixels
xinput --set-prop --type=int --format=8 "SynPS/2 Synaptics TouchPad" "Synaptics Tap Action" 0 3 0 0 1 2 0
```


Open `System` => `Preferences` => `Startup application` and add a new startup item :

```bash
sh /path/to/your/script.sh
```

And voila, you've got :

	
  * two fingers scroll (vertical and horizontal)
	
  * single tap for single click
	
  * two finger tap for middle click
	
  * right bottom tap for right click

The reason for the sleep is to give the xinput server time to init after the login..

Works on my Lenovo w520, with a 32bit Ubuntu 10.10.

Reference : [http://www.x.org/archive/X11R7.5/doc/man/man4/synaptics.4.html](http://www.x.org/archive/X11R7.5/doc/man/man4/synaptics.4.html) and [http://manpages.ubuntu.com/manpages/karmic/man4/synaptics.4.html](http://manpages.ubuntu.com/manpages/karmic/man4/synaptics.4.html)

Enjoy!
