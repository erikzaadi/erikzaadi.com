---
title: "Putting the AI in TUI: When You Have 43 Minutes and a Commit Stuck in Your Head"
date: 2025-11-07T11:26:53+02:00
description: >
  How a busy engineering manager finds real coding flow in 43-minute windows, powered by Vim, tmux, Devbox, and a terminal-native AI assistant.
  Cold brew optional, terminal required.
tags: ["AI", "developer-experience", "terminal", "vim", "tmux", "devbox", "cursor", "productivity", "engineering-management", "flow-state"]
image: "/images/brew-ai-tui.png"
toc: true
aliases: ["/ai-in-tui"]
---

## Putting the AI in TUI: When You Have 43 Minutes and a Commit Stuck in Your Head

{{< paddedimage "/images/brew-ai-tui.png" "Brewing code" >}} 

I don’t get a lot of uninterrupted time these days.  
Between one-on-ones, planning sessions, and enough Slack threads to qualify as a second inbox, “deep work” has become something of a nostalgia act.

But no matter how managerial life gets, one thing stays the same.  
I’m a terminal person through and through. [Vim](https://neovim.io/) is still home, and no fancy IDE or glowing dashboard has managed to replace it.

There’s something about the hum of the terminal, the green-on-black minimalism (well ish, I use [gruvbox](https://github.com/morhetz/gruvbox) like a proper geek), the absolute focus it demands. No tabs. No distractions. Just you, your thoughts, and maybe an occasional `:wq` in a Slack thread you didn’t mean to type.

So when I found myself one weekday evening with exactly **43 minutes to kill** while waiting for my kid to finish parkour training, I did what any reasonable person would do:  
I opened my terminal.

No IDE. No browser. Just my laptop, a cold brew, and an idea that had been quietly pinging around my brain for two days, the kind of "small" code tweak that only grows louder the longer you ignore it.

That’s when I realized just how far my **AI-in-the-terminal** workflow had come. Between [`cursor-agent`](https://cursor.sh/) and the [`cursor` CLI](https://cursor.sh/docs/cli), I could boot up, recall context, and get into flow *fast*, even in the stolen moments between dad duties and developer daydreams.

### The Setup: My AI-Powered Terminal Flow

My home base is a terminal split into panes of purpose and comfort.  
I live in [`tmux`](https://github.com/tmux/tmux) and Vim, the two constants in a world of shifting frameworks and endless Chrome tabs.

Usually, I keep my editor pane zoomed in. It’s my focus zone, where ideas turn into code. When I need to context-switch, I unzoom it and bring up two trusty companions:  
one CLI pane for `git` commands and another running `cursor-agent`.

It’s a setup that feels both old-school and futuristic.  
Vim for precision, tmux for control, and `cursor-agent` for that quiet, context-aware AI boost when I need to get unstuck or move faster without leaving the terminal.

At Port, we use [`devbox`](https://www.jetpack.io/devbox/), which makes this workflow even smoother.  
Even if I’ve missed a couple of Node.js version upgrades (which, let’s be honest, happens more often than I’d like to admit), I can spin up a fresh, up-to-date environment in under a minute.  
No “works on my machine” moments, no dependency archaeology. Just instant context and focus.

### The Flow: From Idea to Commit in Minutes

The idea for the change wasn’t born in that parkour session.  
It started earlier, during an issue where a customer ran into some strange behavior caused by corrupted data in Redis.

The behavior itself was technically “by design”. When our code detected a cyclic dependency, it flattened the folder structure instead of failing. It wasn’t wrong, exactly. It even allowed the customer to keep getting business value.  
But it *felt* wrong. The folder structure just vanished, and debugging why was... not fun.

We eventually traced the root cause with the help of ChatGPT (which analyzed a massive JSON payload, bless its tokenized soul), but the experience exposed two obvious improvements:  
1. **Add proper logging** when this flattening happens, with enough context to pinpoint where the cyclic dependency originated.  
2. **Attempt to self-heal** the data if possible, instead of silently masking the issue.

So that parkour evening, I decided to finally build it.

I fired up my setup, tmux, Vim, `cursor-agent`, and a fresh devbox environment, and in exactly two minutes I was writing code.  
The first change was simple, add contextual logs around the flattening logic.  
Then I pulled in `cursor-agent` to help me write a clean set of tests for the new behavior.  

From there, it turned into a beautiful back and forth.  
I’d review the AI’s suggestions, tweak where needed, then prompt for improvements.  
I’m still pretty opinionated about code style, so nothing merges without a good re-read, but the workflow felt *natural*. The AI handled the mechanical parts while I focused on intent and polish.

At one point, while re-reading the tests, I realized I’d missed verifying the “good” path, that the valid, non-cyclic case still worked. One quick prompt and the test appeared. One small manual styling pass and **poof**, done.

What used to take a few context-switch-heavy hours of setup and iteration now fit neatly into a 43 minute coding window.  
The kind of session that reminds you that flow state isn’t about time, it’s about tools, focus, and a bit of cold brew.

### Examples, Prompts I Actually Used

Some of the prompts that made this 43 minute session so productive:

> **Run tests, TypeScript, and lint validations on all changed files in this branch**

A simple prompt that keeps my quality gates consistent. I love that I can ask it conversationally and let the agent handle the boilerplate scripts.

> **Could that code introduce a race condition? If so, let's add a locking mechanism**

This one often catches subtle concurrency issues before they happen. The agent usually proposes a lightweight solution, and I refine it for our specific runtime and stack.

> **I personally prefer not to do `.forEach` loops in Node, both in terms of styling and in terms of flow, let's change that to a reduce function instead**

My personal style quirk, but it’s nice having an AI that just adapts to your preferences instead of fighting them.

These kinds of micro interactions add up fast. Each small assist saves cognitive load, letting me stay in flow longer and focus on intent rather than ceremony.

### Reflections

AI did not write this change for me, it compressed the ramp up.  
Spinning devbox gave me a fresh environment in under a minute, tmux and Vim kept me focused, and cursor-agent handled the heavy lifting around tests, quick refactors, and safety checks. I stayed in the terminal, I stayed in flow, and I shipped something that made a real customer experience better.

The manager reality is a fragmented schedule.  
The win here is not magic, it is removing friction. Fast context, quick safety nets, repeatable checks, and tiny prompts that turn into useful diffs. I still review every line, I still make the final calls on style and structure, but the boring parts move faster and the interesting parts get more of my attention.

Flow is not only about long hours, it is about tight loops and good tools.  
With this setup I can use a 43 minute window, move from idea to commit, and get back to pickup with a small but meaningful improvement merged. Cold brew optional, terminal required.

### TL;DR

I went in with 43 minutes and code stuck in my head.  
I left with clean logs, passing tests, and the quiet satisfaction that sometimes, the best kind of flow fits neatly between parkour and pickup.

{{< paddedimage "/images/chezy-ai-tui.png" "Dream" >}} 
