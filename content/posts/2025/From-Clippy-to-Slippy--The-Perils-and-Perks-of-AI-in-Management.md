---
title: "From Clippy to Slippy: The Perils and Perks of AI in Management"
date: 2025-08-17T07:51:24+03:00
slug: 'clippy-to-slippy'
tags: ["AI", "Management", "Leadership", "Productivity", "Humor"]
description: 'If you were around in the early 2000s, you probably remember Clippy, the overly eager paperclip who popped up in Word to offer ‘helpful’ tips like how to write a letter (spoiler: nobody asked). Fast forward to today, and Clippy’s spiritual descendants are everywhere, only now they’re called AI assistants. As a manager, I’ve found that leaning on AI can feel like going from Clippy to Slippy: sometimes it smooths the path and saves me hours, and other times it slips me into awkward mistakes, tone-deaf messages, or content that reads like it was written by… well, a paperclip. This post is my testimony of both the perks and perils of letting AI sneak into management work.'
---


{{< paddedimage "/images/clippy-intro.png" "Clippy Intro" >}} 

*Remember Clippy? That overly enthusiastic paperclip who just knew you were writing a letter (even if you weren’t) and insisted on helping?  
Fast forward to today, and Clippy’s descendants have gotten a serious upgrade, they now run on large language models and call themselves ‘AI assistants’.*  

As a manager, I’ve learned that using AI can feel a lot like going from **Clippy to Slippy**: it smooths some bumps, but it can also make you slip on things you’d normally catch.  
One moment, it’s saving me hours drafting a doc or prepping a team update; the next, I’m shipping something that reads polished but lacks empathy, context, or even relevance.  

That’s the double-edged sword of AI in management, it’s a powerful tool, but it’s not a replacement for judgment, empathy, or accountability. Here’s my testimony of both the **perks and perils**.

## The Perks: When AI Makes You a Supermanager  

### Drafting Documents

{{< paddedimage "/images/cntrl-gpt.png" "CMD+C, CMD+GPT" >}} 

I write a lot of content, EVEN [ALOT](https://www.urbandictionary.com/define.php?term=ALOT)!

Previously, my workflow was simple, a tad bit tedious, but working:

1. Write up initial DUMP of thoughts
1. Refine to have a proper story and form
1. Format for clarity
1. Add puns and gifs
1. Repeat 2-4 until I'm happy with the result

Now, with my trustworthy AI companion(s):

1. Dump initial thoughts into AI
1. Ask for more puns and gifs
1. Validate output

The amount of time saved until I have something shareable for initial feedback has gone down drastically, and with the hectic calendar of any manager, that's pure gold.

### TL;DR me plz

There are piles of information streamed to you as a manager each day, Slack threads, documents, even meetings (THE DREAD!).

I love using the whiteboard to help thought processes in meetings, being able to take a picture of a messy whiteboard to get the quick gist of what was in the meeting is just AMAZONG.

{{< paddedimage "https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExOGxjeWxxaDUxOTRjOW41emZlb3phOTg4dzh2eTYxdXQ4cWRqaWtmZCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/d2ZeJSRDqd8P4RIQ/giphy.gif" "Always be summarizing" >}} 

Summarizing a long slack thread to quickly get to the root issue and generate action items, BOOM, AI has your back!

### Tedious Work

Find a similar bug / incident, go over 5000 lines of logs, extract meaningful data from yet another csv.

### Visualizing Data

Whether cheesy dad pun turned into cringe AI images, analyzing an export of alerts or even graphing data to help communicate it to the masses, AI saves you loads of time.

{{< paddedimage "/images/coffee-correlation.png" "Correlate this!" >}} 

### Brainstorm Buddy

I love using AI to just converse thoughts and questions that randomly pop into my head.

> What's the difference between a Team Leader and an Engineering Manager

> I want to start DAT initiative, what could be the possible pitfalls?

> I've listened to this amazing podcast, which by chance also has the transcripts for all episodes, could you summarize the top tips mentioned and the books recommended to read?

> Here's a link to a draft blog post I wrote, could you give some thoughts about what might be improved?

> I want to do a hackathon event at work, here are the important parts I want to emphasize... 

> Here's the wanted data flow for a design document, could you graph that up using [Mermaid](https://mermaid.js.org/) so it can be paste-able in Notion?

> Here's my AMAZONG peer Morpi's profile image, can you combine that with this MEME of "you are a man of culture as well"?

> Here's a transcript of a call with a customer, could you refine out what is the most crucial parts we should address next?

*(Clippy could never help me write a quarterly OKR doc, but ChatGPT™ can.)*  

## The Slips: When AI Trips You Up  

### Tone-Deaf Outputs
While ChatGPT knows me and my punny style, sometimes it generates content lacking empathy, nuance, or human touch.  

### Over-Polished but Empty
Some output may look shiny, but quickly devolves into emoji-laden streams that confuse more than they help.

### Shortcut Temptation
It’s just so easy to generate → ship. That’s the danger: skipping the reflection step.  

### Hallucinations
AI can produce overconfident “facts” that are simply out of this world.  

(Clippy never hallucinated, he just annoyed us with letters. At least his “Did you mean…?” was technically true.)

## Lessons Learned (aka: How Not to Get Too Slippy)  

- Always *PROOFREAD* & add empathy, AI drafts, *you* lead
- Use AI for *SCAFFOLDING*, not as a finished product
- Be *TRANSPARENT* with your team about when you use AI
- Remember: AI doesn’t take *ACCOUNTABILITY*, you do
- *CONTEXT* is king: 
  > Please don't use horizontal separators when creating Notion documents  
  Stop using `—` and prefer a good old comma  
  NO PERIOD AT THE END OF BULLETS, IT DRIVES ME CRAZY!!1
  
## Choosing The Right Tool

There's a multitude of AI's available for you at the moment, and the truth is that there is no correct tool, it changes so much.

I personally mainly use ChatGPT, for all non code related prompts, and Cursor (CLI) for coding.

I've yet to delved into properly using Claude Code or Gemini, but heard good things.

The fact that you can wire up MCP servers for extra context is just mind blowing, at [Port](https://www.port.io), we love dog fooding, and we're using our own Port-al (Pun intended), which is connected via MCP to our prompts, automagically connecting context (and actions ofc) of EVERYTHING in our org, Jira tickets, Pagerduty, Weekly On Call summaries, you name it, we got it.

Imagine being a prompt away of understanding similar bugs, detecting people that have had more hectic on calls and much more, as a manager these query capabilities aid me in not only understanding my swashbucklers pains, but also in how to overcome them (E.g. What PRs are taking more time to merge?).

## Closing Thoughts  

AI is like Clippy’s cooler cousin, helpful, fun at times, but still not your manager.  

The real win is finding balance: use AI to amplify your time and clarity, but don’t let it replace your judgment, empathy, or leadership. After all, no one wants to be managed by a paperclip.  

(Though, let’s be honest, he’d still probably run fewer meetings.)

{{< paddedimage "/images/clippy-tired.png" "Clippy's tired!" >}} 
