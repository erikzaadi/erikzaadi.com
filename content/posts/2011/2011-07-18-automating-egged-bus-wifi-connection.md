---
date: '2011-07-18'
slug: automating-egged-bus-wifi-connection
status: publish
title: Automating Egged Bus Wifi Connection
wordpress_id: '323'
comments: true
categories:
- IT
tags:
- egged
- hacking
- wifi
---

On my commute to work I travel by bus, with wifi.

It's one of those wifi's you have to open a browser and click on some license agreement in order to connect.

After agreeing, the browser is redirected to a page filled with commercials, earning yet another referral point to the company that set up this wifi.

Annoying as it might seem, this is not the end of the world, as you overcoming it by clicking is not that bad.

However, if you're in text mode only, or running a headless server as a VM, opening a browser is not an option.

I've created two small scripts, one for the wget lovers, the other for curl, that automate this process.

**curl Version**


```bash
#!/bin/bash
curl --data username=ronen egged.co.il/login
curl egged.co.il/status
```


**wget Version**

```bash
#!/bin/bash
wget --post-data username=ronen egged.co.il/login
wget egged.co.il/status
rm status
rm login
```

Enjoy
