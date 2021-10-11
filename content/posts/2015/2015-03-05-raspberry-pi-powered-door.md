---
title: "BigPanda's Raspberry Pi Powered Geekalicous Door"
date: 2015-03-05
slug: raspberry-pi-powered-door
comments: true
categories: [RaspberryPi, BigPanda, Hacking]
---

We recently moved to a new shiny office at [BigPanda](http://bigpanda.io).

Before moving in, we renovated parts of the office, including the door.
We got a door with an electronic lock, which usually is opened using a code panel.

Alas, we can't have a simple code panel, we're way to cool for that!

![Like a sir](/images/panda-pi/like_a_sir.gif "Like a sir")

So we decided to hook up our Raspberry Pi to control the door.

Here's the Raspberry Pi, all hooked up:

![Our Raspberry Pi](/images/panda-pi/pi.jpg "Our Raspberry Pi")

Here are the buttons we use:

![Buttonz](/images/panda-pi/buttons.jpg "Buttonz")

The black button is the outside doorbell.
The white button is what we use to open the door from the inside.
Behind the AWESOMEz BigPanda logo there's a NFC tag that also opens the door for authenticated devices.

To control our electronic lock, we need to pass 24V/12V on or off to the lock.
To enable this, we create a digital switch using a MOSFET:

![MOSFET](/images/panda-pi/mosfet.jpg "MOSFET")

The buttons are connected to the Raspberry PI via simple GPIO connection:

![Inside button connection](/images/panda-pi/inside_button_connection.jpg "Inside button connection")

One of the great things about the Raspberry Pi is that it's running good old Debian, and has standard connections such as headphone jack and usb.
We used this to hook up a simple USB web cam:

![USB Webcam](/images/panda-pi/webcam.jpg "USB Webcam")

And commodity speakers:

![Speakers](/images/panda-pi/speaker.jpg "Speakers")

The speakers play our custom chosen mp3 files when someone rings the doorbell from the outside and when the door is opened.
The Webcam takes a picture whenever someone rings the doorbell.

We control the Raspberry Pi powered door by http site/api and HipChat.

In HipChat, we have a bot powered by [Hubot](https://hubot.github.com/) which we use to open the door and to see who's calling the doorbell.

![HipChat](/images/panda-pi/hipchat.png "HipChat")

The code is of course open source, up at [https://github.com/erikzaadi/bellboy](https://github.com/erikzaadi/bellboy).

Enjoy!
