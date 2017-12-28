---
title: "Installing Bare Boned Ubuntu using the Mini ISO"
date: 2012-11-11
comments: true
categories: [ubuntu, hack, gnome3]
---

After installing Ubuntu 12.10, I got annoyed by the amount of unneeded software installed, especially the commercial lenses, offering me to buy something for every program I want to launch.

I tried Unity for about two weeks, until I decided I have to change to something else.

I used Gnome 3 with Fedora for a while before, and I really like the native multiscreen support available, that allows you to have a second monitor that doesn't change when you switch workspace.
I missed the diagonal workspace switches from Gnome 2 (and Unity), but it was a pleasant desktop.

About two monts ago I noticed the [Ubuntu Minimal CD](https://help.ubuntu.com/community/Installation/MinimalCD), which is a bare boned text only installation, which is similar to the Ubuntu Server installation, just with less packages.

I decided I'd try to "Arch"-up a bare boned Ubuntu installation with the Mini CD, using Gnome 3 as desktop.

Installing it is a breeze, after some next next wizard that's to similar to the Ubuntu server to write about, I had a text based distro up and running.

One small caveat though, defining Wifi during the installation sucks, do install it while plugged in to an ethernet connection..

Before installing the GUI, I enabled the Gnome 3 PPA, to be up to date with the latest Gnome 3.6 packages held back by Ubuntu:

```bash
#Preparing Gnome 3 PPA
sudo apt-get install -y python-software-properties software-properties-common 
sudo add-apt-repository ppa:gnome3-team/gnome3
sudo apt-get update -y && sudo apt-get dist-upgrade -y && sudo apt-get autoremove -y
```

Then you need to edit `/etc/network/interfaces` and disable your eth0 connection (Will be managed by Gnome Network), just remember **NOT** to restart the networking service..

Install the following to get Gnome 3 up and running:

```bash
#Installing Gnome 3 Components
sudo apt-get install -y gnome-shell gnome-network-admin gnome-terminal \
gnome-alsamixer gnome-bluetooth gnome-tweak-tool network-manager-gnome \
file-roller #add your stuff here like git tmux vim-gnome..
```

And you're good to go, with a snappy non bloated desktop available.
If you want some extra default apps, you can add `--install-suggests` to the `apt-get` command, but it's not needed.

Boot it up by running:
```bash
#Starting Gnome 3
sudo service gdm start
```

Enjoy and prosper!
