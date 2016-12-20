---
date: 2016-01-09T21:42:42+02:00
description: "LAN PARTY FTW"
title: "Dummy Guide To Mac Lan Party With Team Fortress 2"
---

As always, at [BigPanda](https://bigpanda.io), we're very serious about keeping our geek creds high.

So, we decided to throw together a company Lan Party *(FTW)*.

Our needs were simple:

* It should work on our Macs (13" MBP Retina)
* Preferably, should work only using WIFI (Dammit those Thunderbolt => Lan adapters are expensive)
* Should not cost anything extra per participant
* If possible, save the need of a dedicated server

After some digging around, we decided to give [Team Fortress 2](www.teamfortress.com) a try, here's the steps we took:

### Download Team Fortress 2

Tell your lan party guests to download [steam](http://store.steampowered.com/about/) (be sure to troll them if they haven't already), then download [Team Fortress 2](http://store.steampowered.com/app/440/).

### Be connected to a fast network

We're using Airport Extremes at the office, for us it was enough, **YMMV**.

### Prepare hosts and clients

Click on the **Options** button, In the **Keyboard** tab, click **Advanced**, and **Enable developer console**. 

Test by clicking `~`, then rejoice with Quake flashbacks.

### Hosting a server

Write down the IP (Option + Click on the Network icon in the status bar) of one of the Macs before starting.

Click on the **+** sign next to the Servers icon.

Choose a map (notice the naming convention: **maptype_mapname**)

Fire up the development console again with `~`.

Enter the following to make re-spawning faster:

```ini
mp_respawnwavetime 1
mp_disable_respawn_times 1 
```

### Connecting to the server

From the other macs, open then the console (`~`), then enter:
`connect HOST_IP:27015` (Replace `HOST_IP` with the IP you wrote down before).

### Play and enjoy!

### Notes:

We used the host Mac to play, if you have LAG, you might want to make the host Mac in **Spectator** mode.
If that doesn't help, you should probably fire you your own dedicated TF2 server: [Guide](https://wiki.teamfortress.com/wiki/Linux_dedicated_server).
