---
title: "Traffic is the Best Editor"
subtitle: "Commute-driven development"
date: 2026-11-05T07:45:00+02:00
tags: ["ai", "blogging", "productivity", "tools", "hugo"]
description: "Stuck in traffic, I started drafting blog posts by voice. Turns out gridlock is a surprisingly good editor."
draft: false
toc: false
image: "/images/traffic-is-the-best-editor/drivers-seat-blogger.png"
---

### TL;DR

I've been working with generative AI across different tools for a while: Claude Code, Cursor, ChatGPT, Instinct, the works. Grok is what finally made the flow work by voice, stuck in traffic. My Hugo blog and its over-engineered CI/CD made wiring that up almost boring. Traffic is the best editor.

---

This is not a "I just discovered AI" post.

I've been collaborating with generative AI, and with *different* AIs, for a while. For coding, yes. Also for content: presentations, blog posts, the whole creative pile. Jumping between harnesses is part of how I work, not a novelty.

The lineup, for the curious:

- **Claude Code** for the actual coding.
- **Cursor** (CLI included) right there in the same loop.
- **ChatGPT / OpenAI** mainly for images, plus personal travel stuff.
- **Instinct** for personal things.

{{< paddedimage "/images/traffic-is-the-best-editor/harness-convention.png" "The harness convention. Every booth is open, somehow." >}}

Then Grok showed up.

## What Grok Unlocked

What clicked wasn't "yet another coding agent." I'd already had those. It was doing real work *without* being parked in front of a computer.

{{< paddedimage "/images/traffic-is-the-best-editor/drivers-seat-blogger.png" "Me in the driver's seat. Blögger in the passenger seat, taking notes." >}}

I'd tried voice in other harnesses before. It always felt off. Something about the rhythm wasn't there. You talk, it waits wrong, you wait wrong, everyone is slightly awkward, and you go back to typing.

With Grok's voice, it just... clicked. No ceremony. I could think out loud and have it keep up.

And that is a weird sentence coming from me.

I'm a TUI guy. Give me a terminal, vim, and tmux, and I'm home. Fancy editors make me itchy. My happy place has a blinking cursor and too many splits. Voice in a car is about as far from that as you can get without leaving the planet.

So of course I did the only reasonable thing: I automated my personal blog against it and made a voice agent called Blögger. (Yes, with the umlaut. Part of the bit, and a quiet hat tip to my Swedish roots.)

I've been using it ever since.

## Why This Blog Was Easy Prey

One reason this worked so smoothly: the blog is boring in the good way.

It's Hugo. Simple markdown. Open source. Code on GitHub. And being the over-engineer I am, I already had a complete CI/CD workflow for it. Push a non-master branch, get a draft-inclusive preview. Push master, go live. Connecting Grok was basically "give it write access to the repo and respect the preview branch convention."

The whole loop: I talk, Blögger commits to a branch, the preview deploys, I read it once I've parked, and when it's ready I tell Blögger to merge. Sometimes vim gets a pass in between.

Which is how you end up dictating a post on the Ayalon and checking it on a preview URL the moment you park.

*Disclaimer: the Android Auto bit is artistic license. The preview opens in the phone browser, and reading it means pulling over first. Blögger listens while I drive. I only read once I've stopped.*

{{< paddedimage "/images/traffic-is-the-best-editor/android-auto-preview.png" "blogpreview.erikzaadi.com, now playing on Android Auto. As one does." >}}

## Creative Juice, Gridlocked

Traffic used to be pure waste. Now it's where a surprising amount of the drafting happens.

Voice forces a different kind of writing. You can't scroll up and rewrite the same sentence seventeen times. You can't open three tabs to "just check one more thing." You say the thought, hear it back, cut the fluff, and move on. Brevity stops being a style choice and starts being a survival strategy.

Hearing it back means Blögger reads out the main gist (or the whole post, if I ask), and we go back and forth on the parts that drag.

Stuck between two trucks on the Ayalon, there's no room to ramble. There's only room for the point.

A real one, from [Seriousness Intended](/2026/11/04/seriousness-intended/). What I actually said was roughly: "Let's shop images, something about pun and punishments... oh wait, that reminds me of the EPIC Batman trilogy, the Joker's famous 'Why so serious', it'd be AMAZONG to generate an image of me as that Joker." What survived was three words: *Why so serious?* That's the header image and its alt text. The pun and punishment bit got squeezed into a single aside near the end.

So yes: this post, and a few before it, got their shape while I was otherwise totally wasting time in traffic. One of the tools finally fit the commute.

That post went from the car straight to the preview, and I loved it. I read it once parked, sent it to a few people for feedback (my missus included), and later asked Grok to merge it while flipping burgers at a BBQ. Today I started from that same car, then continued in vim. Voice for the first draft, terminal for the polish.

## The Car Confessional

There's a funny tension in all of this.

I love the voice-to-content part. I will happily dictate an entire draft between highway exits. I will not, under any circumstances, do that at my desk.

{{< paddedimage "/images/traffic-is-the-best-editor/office-voice-shame.png" "This meeting is being recorded. Also, please stop whispering at your laptop." >}}

Something about voice-prompting in the office still feels like reading your diary out loud in standup. The car, though? The car is fine. Windows up, road noise on, nobody within earshot who isn't also stuck. It's the only sanctioned confessional booth I have.

{{< paddedimage "/images/traffic-is-the-best-editor/car-confessional.png" "The only sanctioned confessional booth on the Ayalon." >}}

So Blögger gets the commute. The office gets typed prompts, a terminal, and plausible deniability.

Traffic is the best editor. Vim is still the best finisher. And, apparently, the car is the only place I will admit any of that out loud.
