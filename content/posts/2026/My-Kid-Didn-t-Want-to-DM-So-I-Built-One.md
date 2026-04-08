---
title: "My Kid Didn't Want to DM, So I Built One"
date: 2026-04-08T21:47:22+03:00
description: "Built an open source, self-hosted AI Dungeon Master for family D&D nights. POC in under an hour, first playtest was a blast."
tags: ["dnd", "ai", "openai", "nodejs", "react", "family", "gaming", "open-source"]
toc: false
image: /images/dnd-fam-ftw/character-popup-pundemic.png
---

*The DM who never gets tired, never says "I forgot my notes", and always has a pun ready.*

**TL;DR:** My kid wanted to play D&D as a family but nobody wanted to run the game. So I built [dnd-fam-ftw](https://github.com/erikzaadi/dnd-fam-ftw): a self-hosted, AI-powered Dungeon Master for short, family-friendly adventure nights. POC took under an hour. First session was chaos. We loved it.

---

## The Setup

My kid has been into D&D for a while. Books, dice, the whole deal.

The ask: "Can we do a family D&D night?"

The problem: Someone has to be the DM. DMing is prep, rules knowledge, improv, and keeping four people from arguing about whether a table counts as a weapon. It's a lot.

Nobody volunteered.

So I did what any reasonable parent would do: I opened a code editor and outsourced the problem to GPT-4o.

---

## What I Built

[dnd-fam-ftw](https://github.com/erikzaadi/dnd-fam-ftw) is a self-hosted web app where an AI runs your D&D session.

You create a world (or leave it blank for a surprise), assemble your party of heroes, and then the AI takes over as DM. Each turn it narrates what happened, suggests three actions, and you pick one or type your own. Roll a d20. Add your stat. Hope for the best.

{{< paddedimage "/images/dnd-fam-ftw/home-screen.png" "Home screen: pick your world or start a new one" >}}

The whole thing is designed for people who want the vibe of D&D without the homework:

- **Three stats only:** Might, Magic, and Mischief. That's it.
- **d20 rolls:** classic, satisfying, displayed with a proper SVG die
- **AI narration:** short, punchy, family-friendly, with three suggested actions every turn
- **Scene illustrations:** DALL-E 3 generates an image for major moments, with a Ken Burns pan across the scene
- **Real-time sync:** everyone at the table can follow on their own device via SSE

{{< paddedimage "/images/dnd-fam-ftw/narration-panel.png" "The AI narrates, you choose" >}}

{{< paddedimage "/images/dnd-fam-ftw/turn-history-card.png" "Action choices and the d20 result" >}}

---

## The Characters

This is where it got good.

Each hero has a name, species, class, and a quirk. The quirk field is where the AI gets its ammunition.

I made a character called **Pundemic**, an Orc Death Knight whose quirk is: *"Addicted to dad puns, has a small random chance to suddenly think of a pun, then either giggles uncontrollably or has the urge to tell the party the pun."*

My missus made **Mambadelic**, a High Elf Resto Druid whose quirk is: *"Somewhat allergic to dad puns, can respond to them either with uncontrollable eye rolls or even rage."*

The AI took both of these completely seriously.

Pundemic started narrating puns mid-combat. Mambadelic eye-rolled so hard she missed a spell. The dragon we were fighting had to pause and ask everyone to please focus.

{{< paddedimage "/images/dnd-fam-ftw/character-popup-pundemic.png" "Pundemic, the dad pun vector" >}}

{{< paddedimage "/images/dnd-fam-ftw/character-popup-mambadelic.png" "Mambadelic, the long-suffering druid" >}}

Every hero gets an AI-generated portrait. The party screen shows everyone's HP, stats, and inventory.

{{< paddedimage "/images/dnd-fam-ftw/session-header-party.png" "The party, assembled and ready to cause problems" >}}

---

## The Part Where It Took Under an Hour

The initial POC was fast. Like, embarrassingly fast.

The core loop is simple: player submits action, backend rolls dice, sends structured context to the AI, AI returns narration and three new choices, frontend updates. That's it.

The AI never touches game state. It only tells stories. The backend owns HP, inventory, dice, and difficulty. The AI is a performer, not an engine. That distinction kept things clean and kept the AI from doing weird stuff like deciding a character was "actually fine" after taking a fireball to the face.

We played a test session that same evening. It was immediately fun.

{{< paddedimage "/images/dnd-fam-ftw/scene-image-gameplay.png" "Scene image with the savings mode toggle (DALL-E isn't free)" >}}

---

## After the Session

One of the things I'm famous for is my AMAZONG memory.

I was 100% sure that if we'll restart a campaign, I wouldn't remember anything (but the puns ofc).

There's a recap mode for this.

**TLDR mode** gives you a three-sentence AI summary. **Movie mode** plays back every generated scene image as an animated slideshow with Ken Burns effect, pause/play controls, and fullscreen on click.

{{< paddedimage "/images/dnd-fam-ftw/recap-mode-select.png" "Pick your recap poison" >}}

---

## Self-Hosted, On a Laptop

It runs on a Ubuntu laptop sitting on my local network. Nginx, systemd, SQLite. No cloud bill beyond the OpenAI API calls.

There's a savings mode toggle that disables image generation for when you just want to test or don't feel like paying DALL-E prices for every dramatic moment.

Setup is: clone the repo, add your `OPENAI_API_KEY`, run `npm run install:all` and `npm run dev`. Or use the deploy scripts to push it to a Linux server.

---

## Get It

The code is at [github.com/erikzaadi/dnd-fam-ftw](https://github.com/erikzaadi/dnd-fam-ftw).

It's not trying to be Roll20. It's not a full D&D simulator. It's a hilarious, interactive fantasy story night for the family, with dice, AI portraits, and a DM who will absolutely let your dad pun character derail the entire adventure.

Which, honestly, is all I ever wanted.
