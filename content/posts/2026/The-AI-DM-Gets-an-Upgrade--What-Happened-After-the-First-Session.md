---
title: "The AI DM Gets an Upgrade: What Happened After the First Session"
date: 2026-06-01T10:00:00+03:00
tags: ["dnd", "ai", "openai", "claude", "codex", "nodejs", "react", "family", "gaming", "open-source"]
description: "A lot happened to dnd-fam-ftw since the first post: car mode, terminal mode, tiered models, agentic narration, and a workflow where Codex checks the AI facts and Claude writes the code."
draft: true
toc: false
image: /images/dnd-again/dnd-fam-again-openai.png
---

*Car mode, terminal mode, agentic narration, and a development workflow that uses different AI tools for different jobs.*

[Last time I wrote about this](/2026/04/08/my-kid-didn-t-want-to-dm-so-i-built-one/), I had just shipped the first version of [dnd-fam-ftw](https://github.com/erikzaadi/dnd-fam-ftw): a self-hosted AI Dungeon Master for family D&D nights. POC in an evening, first session was chaos, everyone had a good time.

Then we kept playing. And once you keep playing, you start noticing things.

---

## The Things You Notice When You Actually Play

The first problem was latency. An AI DM that makes you wait 15 seconds per turn is funny for two turns, then it breaks the rhythm. We're playing family D&D, not chess by mail.

The second problem was that the AI was doing too many jobs at once. Every turn, one model call was expected to: narrate what happened, invent three choices, handle inventory changes, decide if an encounter started, write an image prompt, and pass quality guards, all as a single structured JSON output. That's too much to ask of one call under a time budget. The overloaded prompt caused errors, which triggered guardrails, which in turn generated "too generic" fallback responses. The story felt stuck, the narration felt flat, and needless to say, it added loads of latency on top.

The third problem: the story continuity, just having the campaign make sense.

E.g. a villain we'd been chasing for three sessions kept getting narratively frozen. She'd be mentioned every turn but never actually show up. The story summary would say something like "snarling against her bonds" for five sessions straight.

Each of these became a plan, and each plan eventually became a bunch of commits.

---

## The Development Workflow That Emerged

Before getting into what changed, I want to talk about *how* things changed, because the workflow evolved into something I'm pretty happy with.

The pattern that settled in:

1. **Codex researches the AI-specific facts.** When a plan involves specific OpenAI model behavior, API quirks, or documented constraints like prompt caching rules or structured output limitations, I use Codex to verify what is actually true. Is `max_tokens` deprecated? What does OpenAI actually say about prompt caching on structured output schemas? Does the Responses API behave differently for reasoning models? Codex is better positioned for this: it has fresh training data on OpenAI docs and can verify behavior against the real API. I don't want to build a latency reduction plan around a caching assumption that turns out to be wrong.

2. **Claude reviews the plan.** Once I have a plan, I run it past Claude Code for review. Not implementation, review. Does the plan make sense given the actual code? Are there edge cases the plan glosses over? Is the proposed architecture going to create problems downstream? Claude reads the actual source files and pushes back where the plan doesn't fit the codebase. Critically, I always ask for an explicit checklist of phases at the end of the review, and then ask which phases can be bundled together. This keeps implementation from becoming a 47-step marathon and catches when two "separate" phases are really just one change.

3. **Claude implements it.** After the review pass, implementation happens in Claude Code. It knows the codebase, handles multi-file refactors cleanly, and flags things when the code doesn't match the plan's assumptions.

The key insight is that different tools have different strengths. Codex is useful for "what does OpenAI actually say about X right now." Claude is better for "here is the full codebase, does this plan make sense, and now write the code."

Both [Codex](https://github.com/openai/codex) and [Claude Code](https://claude.ai/code) lived as CLI panes in my [tmux](https://github.com/tmux/tmux/wiki) session, dancing along with me verifying the code in [(neo)vim](https://neovim.io/).

{{< paddedimage "/images/dnd-again/dnd-take-2.png" "Codex, Claude, and Claude Code as labeled robots at the AI DM Command Center - Also, the answer to why skeletons don't fight each other: The don't have the guts!" >}}

The same tmux session had the dev server running, allowing me to preview, verify and when needed grab exceptions or metrics logs to give as context for Claude. A common thing I mentioned in [Squeezing More Out of Claude on a Personal Account](/2026/05/02/squeezing-more-out-of-claude-on-a-personal-account/) is that I had another tmux pane just for running npm commands for verifying `lint`, `tsc` and tests (instead of having Claude waste tokens for parsing the output each time).

---

## The IDEAtion => implementation phase

Once I had that development workflow, throwing things to markdown plans became easy, which caused my crazy ideas to just continue popping up.

Weekly metrics sent to my smart watch, hell, why not?!?

End to end visual tests with screenshot comparison, [playwright](https://playwright.dev/) here we go!

Party buffs? Keyboard shortcuts, everything goes!

Feedback from my kid? No problems! Fixed in production in a matter of minutes.

This caused 56 markdown plan files to accumulate in `previous-md-instructions/`. A curated selection of the highlights:

```
./previous-md-instructions
├── too-much-is-too-much.md
├── we-gone-done-it.md
├── frozen-villain-detection.md
├── car-mode.md
├── terminal-adventure-mode.md
├── agentic-workflow-and-deterministic-stitching-plan.md
├── short-lived-buffs-plan.md
├── npc-battle-state-plan.md
├── dynamic-encounters.md
├── realm-origin-story.md
├── visual-asserts-plan.md
└── aws-infra-terraform-guide.md
```

{{< paddedimage "/images/dnd-again/dnd-fam-again-home.png" "The redesigned home screen" >}}

---

## The 5-Second Rule

The latency plan was called "Too Much Is Too Much" internally. The goal: 5 seconds from Submit to Submittable. Visible narration text, three playable choices, under 5 seconds.

Just to compare, it previously could be up to 45 seconds per turn, mainly due to me adding waaaaaay too many features, causing the game play to be, _ahem_, not playable.

The biggest find: the DM prep context (the world-building notes you write before a session) was massive, and it was being passed in full to every single turn. The request bloated, token costs exploded, and latency followed. The fix was to extract only the relevant slice of DM prep per turn rather than dumping the whole thing every time.

The fix was a combination of things: shrinking the prompt, removing that blocking pre-call, tiering models per use case, and capping output tokens. The prompt had grown to six or seven sections, some approaching 10,000 characters, with one always-included section that fired even on the most basic turns. A lot of that moved to conditional-only or got cut.

To verify the prompt caching behavior (stable prefix ordering, whether structured output schemas are cached separately), Codex confirmed the current OpenAI documentation before the implementation went in. That "does this actually work the way I think it does" check is where that part of the workflow pays off.

{{< paddedimage "/images/dnd-again/dnd-fam-again-breadcrumbs.png" "A turn in action: narration, dice result, and three choices" >}}

---

## Tiered Models

Related to the latency work: not everything needs the same model.

The app now has three tiers:

- **Narration tier** (`gpt-4.1-mini`): user-blocking, latency-sensitive, structured JSON output. The turn narration, adventure recap, character summaries.
- **Preview tier** (`gpt-4.1-nano`): tight timeouts, tiny outputs, very high call frequency. The "preview what this action would do before committing" flow, stat suggestions, session name generation, and DM prep compilation.
- **Async tier** (`gpt-4.1`): not real-time, but quality matters here. Campaign brief generation and rolling story summaries.

Previously everything was `gpt-4o-mini` via a single `OPENAI_MODEL` env var. The tiered setup has per-tier env vars with sensible fallbacks, so model choices can be tuned without touching code.

This was another place where Codex earned its keep: for the structured-output and streaming calls in the agentic orchestrator, Codex flagged that `max_completion_tokens` is the correct parameter rather than the older `max_tokens`. Scoped to those paths, not a blanket sweep, but exactly the kind of detail that wastes 30 minutes if you miss it.

---

## Car Mode

The idea: a hands-free, voice-driven route at `/session/:id/car`. Road trips are covered now!

The screen shows minimal state (pause, replay options/story), TTS reads each turn aloud, and STT listens for the response.

The experience target was closer to a voice-driven BBS text adventure than a stripped-down version of the regular session screen. Small command vocabulary, readable transcript, clear voice prompts.

A few specific design decisions worth calling out:

The audio conductor never starts the microphone while TTS is still playing. This sounds obvious but it's the primary failure mode: the mic hears the speakers and picks up the AI reading option numbers, then submits option "two" because it heard "option two" in the narration. There's a hard delay after TTS ends before STT opens, plus an abort if unexpected audio fires.

The pause/resume implementation deliberately doesn't use `speechSynthesis.pause()` and `speechSynthesis.resume()`. Both are unreliable in Chrome and on iOS/macOS Safari, and they frequently hang the speech queue permanently. Pausing is destructive: stop everything, save where you were, and replay from the segment start on resume. That's reliable across all browsers.

Recurring audio blobs (things like "say option one, two, or three", the listen prompt, stable character introductions) are cached with an LRU map in the TTS service. Versioned cache keys so wording changes invalidate old audio automatically.

{{< paddedimage "/images/dnd-again/dnd-fam-again-zara.png" "Zara Spellsworth, Elf Mage, owner of the Arcane Crouton" >}}

---

## Terminal Adventure Mode

Car mode has a command vocabulary: help, repeat, options, status, party, gear, where are we. Once that runtime existed, terminal mode was the obvious follow-up.

Route: `/session/:id/terminal`. A real terminal aesthetic with a scrollback pane, monospaced text, prompt at the bottom, command history with up/down arrows, Ctrl+L to clear scrollback. The same command vocabulary as car mode, just typed instead of spoken.

It's currently a pure easter egg: there's no button or link to get there, you have to know to change the URL. Which honestly feels appropriate. Maybe a Konami code in the regular session view that redirects you there. That's on the list now.

One detail worth noting: in the `keydown` handler, ArrowUp and ArrowDown call `event.preventDefault()` immediately before moving through history. Without this, the browser moves the cursor to the start or end of the input field and you get visible jitter before history navigation kicks in. Tiny thing, noticeable when missing.

Scroll anchoring: only auto-scroll to the bottom when the user is already within 40px of the bottom or has just submitted a command. Don't force-scroll someone who scrolled up to re-read a narration from four turns ago.

---

## Frozen Villain Detection

The villain problem was an interesting one.

During story compaction (which happens every 5 turns), the story summary would narratively lock a boss character into a static state even when the AI was supposed to escalate toward confrontation. Writing "snarling against her bonds" into the summary was the AI's way of preserving continuity, but it was also preventing the actual climax from happening.

The fix: frozen villain detection in the compaction step. If a named boss or elite appears in multiple player actions in the compaction window but isn't an active encounter and isn't in `pastEncounters`, the compaction injects a `FROZEN CONFRONTATION` marker into the story summary. The narration model reads this and is forced to actually do something about it.

Location stall detection came with it: the current scene is passed into the compaction prompt, and the model is asked to confirm whether the recent narrations show the party still in the same location. If so, it injects a `LOCATION STALL` marker into the summary, prompting the next narration to find a reason to move. Interestingly, the original plan intended this to be a deterministic code-level check, but the implementation ended up delegating the confirmation to the model itself.

---

## The Agentic Path

The most recent big change: replacing the single all-in-one narration call with a deterministic orchestrator.

The old architecture was one model call that had to do everything: roll narration, main narration, choice generation, inventory suggestions, encounter state, image prompt, all as one structured JSON output. For complex turns this was the main source of tail latency.

The new architecture has the orchestrator emit the deterministic parts immediately (roll outcome, roll narration before any model call), then run AI tasks in parallel with per-task deadlines, then merge results with deterministic fallbacks for anything that times out. Required tasks (narration, choices) have tight deadlines. Optional tasks like inventory and combat agents run in parallel inside the orchestrator with their own deadlines, falling back to null if they miss them. Image generation is the exception: it's the one task that can genuinely arrive after `turn_complete` via a separate SSE event.

This is what ["Agentic AF"](https://github.com/erikzaadi/dnd-fam-ftw/commit/dad9ab91f0d4c0afbe0e29ba79cf1d86c92075cd) means in the commit history.

The SSE contract didn't change. The frontend already handled `narration_streaming_done` and `turn_complete` as separate events. The orchestrator just made that boundary sharper.

---

## What's Left

{{< paddedimage "/images/dnd-again/dnd-fam-again-story.png" "The AI narrating a goblin diplomacy situation" >}}

The plan files in `next-up-instructions/` always have a `thoughts.md` section that never quite empties.

The family still plays. The villain showed up. Pundemic still derails combat with puns. Mambadelic's eye-roll has reached mythic power levels.

The code is at [github.com/erikzaadi/dnd-fam-ftw](https://github.com/erikzaadi/dnd-fam-ftw).
