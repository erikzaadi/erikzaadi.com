---
title: "LAN Party Guide 2.0: Warsow vs Warfork"
date: 2025-06-22T22:03:47+03:00
description: "Your go-to setup guide for hosting classic fast-paced LAN FPS games using Warsow and Warfork—especially if you're on a Mac."
tags: ["lan party", "warsow", "warfork", "gaming", "mac"]
---

For years, my go-to LAN party game was **Team Fortress 2** which was pure chaotic fun.

![](https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExdDdmc3h6YjdqNnRpM2t5eTc3dDJ3c3A5aHh6bjlrbXRsdG45OHNteSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/lbs3JZRLoirw4/giphy.gif)

(as seen in my [previous lan party guide](//2016/01/09/dummy-guide-to-mac-lan-party-with-team-fortress-2/))

But ever since Apple’s transition to ARM-based processors, TF2 has sadly become a impossible to run natively on modern Macs.

Enter: `War{sow,fork}`.

This post is a quick guide to getting a LAN party running using these two excellent (and free!) arena shooters.

---

## War-WHAT?

[Warsow](https://warsow.net/) is a fast-paced, cel-shaded, movement-heavy FPS. It’s completely free, runs great on older machines, and plays well with macOS via Rosetta.

[Warfork](https://warfork.com/) is a fork of Warsow created after some unfortunate drama in the Warsow project. It’s still being updated, easier to host, and installs through Steam (still free!).

### TL;DR: Which to Use?

| Feature            | Warsow           | Warfork          |
|--------------------|------------------|------------------|
| Install Ease       | ✅ Brew/Manual    | ❌ Steam only     |
| Server Setup       | ❌ Tricky         | ✅ LinuxGSM       |
| LAN Friendly       | ✅ Yes            | ⚠️ Steam needed   |
| Updates            | ❌ EOL            | ✅ Active fork     |

**TL;DR**:
- **In-person LAN party?** Use **Warsow**.
- **Remote online party?** Use **Warfork**.

### LEGGO

![](https://preview.redd.it/hqz0de4vwsa61.jpg?width=640&crop=smart&auto=webp&s=26b35e90fa651338fd238c869c35b6de28afd002)

---

## Warsow Setup (In Person Friendly)

### Installation

```sh
brew install warsow --cask
```

Or download the [latest .dmg](https://warsow.net/warsow-2.1.2.dmg).

### First Run (macOS)

1. Open **/Applications**
2. Right-click Warsow → **Open**
3. Approve the Rosetta install and security warnings

**NOTE:** If “Open” doesn't appear, try right-clicking instead of double-clicking.

### Hosting a Game

1. Click **New Game** → **Local Game**
2. Set a recognizable server name
3. ❗ **Uncheck “Public Server”**

### Joining a Game

- Look for the server on the LAN list
- If not visible:
  - Click **Refresh**
  - Or go to Manual → Type the host’s IP
  - Or open console and run:

```sh
/connect 192.168.x.x
```

---

## Warfork Setup (Steam Required)

### Installation

Install from [Steam](https://store.steampowered.com/app/671610/Warfork/)

Then connect to a host using:

```sh
/connect <host_ip>
```

### Hosting a Game

Follow the LinuxGSM guide:  
👉 https://linuxgsm.com/servers/wfserver/

Set the following in your config:

```ini
sv_public="0"
sv_maxclients="8" # Or however many players + ~2
```

**NOTE:** You’ll need to open the following network ports:

```sh
TCP: 44444
UDP: 44400
```

---

## Common Settings and Gameplay Tips

### Game Modes

- **FFA** – Free For All
- **TDM** – Team Deathmatch
- **Bomb & Defuse** – Objective chaos

### Maps

Start with any map with “bomb” in the name for fun. Some favorites:

- `wdm5`
- `wdm10`
- `bomb3`

### Player Setup

1. Go to **Options** → **Player**
2. Set your **name**, **clan tag**, and **model**
3. Save your changes!

---

## Pro Tips

- Run the tutorial before playing (trust me)
- Set your **FOV** to `100–110`
- Cap your FPS higher with:

```sh
/com_maxfps 250
```

- Learn **bunnyhopping** – it's essential
- Use headphones for positional audio advantage

---

## LAN Party Troubleshooting

| Issue                 | Fix                                     |
|-----------------------|------------------------------------------|
| Can’t see server      | Disable firewalls, same subnet required |
| Mouse input lag       | Turn off mouse accel in game settings   |
| Can’t join via IP     | Double-check local IP / firewall        |
| Audio problems        | Use headphones                          |
| Keep on dying         | GIT GOOD                                |

---

## Final LAN Party Checklist ✅

- Downloaded & tested game
- Name, clan tag, and model set
- Ran the tutorial once
- LAN/Remote host confirmed
- Local:
    - Everyone’s on same Wi-Fi
    - Refreshments + snacks 🍕🍺
- Remote:
    - Zoom / Discord
---

Have fun, enjoy your `supercaliFRAGilisticexpialidocious`!

![](https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExOHRhdjVhbDJkbTRzdjR5YXhxbjE5amplcnU3amp1cHV0ZGhicHRxZyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/e2GSTC7fpvkGc/giphy.gif)
