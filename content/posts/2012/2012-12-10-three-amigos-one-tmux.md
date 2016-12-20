---
layout: post
title: "Three Amigos One Tmux"
date: 2012-12-10
comments: true
categories: [coderetreat, nodejs, gameoflife, telnet]
---

**TL;DR:** `telnet gameoflife.erikzaadi.com 1337`

This Saturday (8th of December, 2012), was the second [Global Coderetreat](http://globalday.coderetreat.org/), and I was amongst the lucky ones to participate from [Tel Aviv](http://coderetreat.co.il).

The event was epic, 30-ish geeks pairing up to 45 minutes of hacking sessions on [Conway's Game Of Life](http://en.wikipedia.org/wiki/Conway's_Game_of_Life).

And that was just in Tel Aviv, about 3500 people worldwide took part in this Geekathon.

The last session I teamed up with [Roy Rothenberg](http://www.royr.net/) and [Pablo Klijnjan](https://twitter.com/pabloklijnjan) (Yes that last name is in Klingon), both my day to day teammates at work.

We had this idea of making a Telnet version of Game Of Life, inspired by the [Telnet Nyan Cat](http://miku.acm.uiuc.edu) ( `telnet miku.acm.uiuc.edu` ).

We hacked together a working Python version in that session, that I thought would be hilarous if it was available online.

We used a very simply Telnet server using Python's `socket` module and most of the time was spent understanding how the f#!@#k to clear the screen:

```javascript
#Clear telnet screen, works for console as well
self.conn.send(chr(27) + "[2J") #chr(27) == <ESC>
```

The problem with the Python version we hacked together was that if you connected more than one Telnet client, it would crash.

During the session we looked at using Twisted to improve the Telnet server, but we had a crappy connection and it took ages for it to download.

Yesterday when I looked at improving the code to make it available online (yes I didn't delete that sessions' code :$), I had a look at some Twisted Telnet implementations, but the code was to Twisted for me. 

Reactor this, Factory that. No thanks.

So, I decided to hipster up and try it in nodejs, initially setting a 45 minute target as one of the sessions we did at Coderetreat.

![Node.js hipster](/images/nodejshipster.jpg)

Getting up the Telnet server was easy, a quick `npm search telnet` found me [wez-telnet](https://github.com/wez/telnetjs).

Writing the coffeescript version of The Game Of Life took me most of the time.

I used [Mocha](http://visionmedia.github.com/mocha/) as testing framework, which is very smooth.
Writing the game and telnet server took me about 55 minutes (while multitasking other stuff).

I tested the Telnet server by connecting from 10 clients from different machines in our network, seem to not even flicker.

When I connected via [ConnectBot](https://play.google.com/store/apps/details?id=org.connectbot&hl=en) on my Android, it crashed the server.
So, before putting it up online, I needed some kind of daemon that restarts the server if (*when*) it crashes.
This was easy with [forever](https://github.com/nodejitsu/forever).

Here's the entire `package.json` with the scripts for testing, testing continuously, starting and stopping daemon:

```json
{
  "name": "GameOfLifeTelnet",
  "version": "0.0.1",
  "description": "See readme",
  "main": "node_modules/.bin/coffee index.coffee",
  "scripts": {
    "test": "node_modules/.bin/mocha --compilers coffee:coffee-script -R spec tests",
    "watch": "node_modules/.bin/mocha --compilers coffee:coffee-script -w -R min tests",
    "daemon": "NODE_ENV=production node_modules/.bin/forever start -c node_modules/.bin/coffee index.coffee",
    "stop": "NODE_ENV=production node_modules/.bin/forever stop 0"
  },
  "repository": "https://github.com/erikzaadi/GameOfLifeNodeTelnet",
  "dependencies" : {
    "coffee-script"   :  "*",
    "wez-telnet"    :  "*",
    "forever"     : "*"
  },
  "devDependencies": {
    "chai" :  "*",
    "mocha" :  "*"
  },
  "author": "Erik Zaadi",
  "license": "MIT"
}
```

So to get this working, all you need to do is clone the repo and one npm command and you're done:

```bash
git clone https://github.com/erikzaadi/GameOfLifeNodeTelnet
cd GameOfLifeNodeTelnet
npm i
```

To run tests:

```bash
#Running Mocha tests
#simple test run
npm test
#continuous test run
npm run-script watch
```

To run as a daemon:

```bash
#starting
npm run-script daemon
#stopping
npm run-script stop
```

Grab the [source code](https://github.com/erikzaadi/GameOfLifeNodeTelnet) or run the live sample:

```bash
telnet gameoflife.erikzaadi.com 1337
```

```stars
✩✩   ✩       ✩      ✩✩        ✩✩   ✩      ✩✩
✩✩    ✩ ✩✩  ✩✩               ✩✩✩✩  ✩✩✩✩ ✩ ✩✩
✩                           ✩✩
✩  ✩            ✩✩✩   ✩  ✩✩    ✩
✩                  ✩          ✩       ✩ ✩        ✩
✩         ✩✩✩             ✩✩   ✩✩            ✩ ✩   ✩
✩ ✩       ✩✩✩     ✩ ✩     ✩✩   ✩✩     ✩    ✩   ✩
✩✩      ✩✩✩                    ✩✩       ✩✩       ✩
✩✩✩
```

Enjoy and prosper!
