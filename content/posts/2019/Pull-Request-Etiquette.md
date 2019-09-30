---
title: "Pull Request Etiquette - A set of simple rules for your code review"
date: 2019-09-29T14:11:15+03:00
draft: false
description: "What human touches you can add to your review processes that'll make you rock"
tags: ["code-review", "pull-request", "ci", "continuous integration"]
---

# Pull Request Etiquette

Pull Requests are by now an industrial standard.

## Why should we do code reviews / pull requests?

### Focus

The committer will be forced to think about how clear and relevant the change is, simply due to the fact that another human being needs to be able to understand _WHAT THE DUCK IS GOING ON_.

### Learning

Code review is an amazing opportunity for making both the committer and the reviewer learn.

### Ensure code standards

Enforce your company style guide and more.

### Ensure relevance

Is this change needed?

Is it too big, risky?

#### OK, the why is clear

## How to open a pull request

#### AKA the reviewee

![](https://media.giphy.com/media/MsWmUYLxqeHmM/giphy.gif)

### When to open a pull request

A pull request can be opened whenever the first push occurs.

Pull requests should be opened as [draft](https://github.blog/2019-02-14-introducing-draft-pull-requests/).

### The pull request content

The title should preferably be prefixed by **[WIP]** _(at least that's the convention at [BigPanda](https://bigpanda.io))_.

Do not assign any reviewers, as it's not review-able yet.

The body of the pull request message should include the wanted gist of the change. This a great place to put a checklist validating the general idea of the change, like a mini design intentions.

### Pushing commits

You should push as much as you wish when working iteratively.

Commit messages *CAN BE ANYTHING*, you'll reword them later when rebasing. Make them understandable at least for yourself. Use conventions whenever possible, especially when working together with peers on a branch. E.g prefixing with **[FIXUP]**, **[SQUASH]** and **[DROP]**.

Fetch master and rebase often.

Whilst not mandatory, I do recommend doing at least daily cleanups using `git rebase --interactive`.

Meet your new best friend: `git push --force-with-lease`[¹](https://git-scm.com/docs/git-push#Documentation/git-push.txt---force-with-leaseltrefnamegt) which will force push only if you were the committer of the to be overridden commit, perfect for collaboration.


### Preparing for review

![](https://media.giphy.com/media/Rd7pEbE7rjZz8vySuU/giphy.gif)

### Git log should be a poetic story

![](https://media.giphy.com/media/oxmjej52wTWOQ/giphy.gif)

#### Commit message format is incredibly important

You'll be the one to look at in half a year to understand what in the name of Odin's beard made you write that code.

Each commit should be a single logical change, other dangling _FIX_ or _TYPO_ commits should be squashed.

### Git commit format

```markdown
Capitalized, short (50 chars or less) summary

Body:
    * Text explaining the change if need be
    * Ticket/issue mention if applicable
    * Text wrapped at 72 characters
    * No typos `:set spell`
```

### Pull request format

Title should **NOT** be prefixed with **[WIP]**.

Body should include the gist of the change (pun intended).

Links to resources if needed

* dependencies (Other pull requests)
* docs
* runtime instructions
* ticket/issue

### Checklist

All tests should pass.

New code should be covered by new tests.

Lint your code.

Style guide **MUST** be respected.

Git log is pretty and easily review able.

Your branch is up to date with `master`.

Your pull request is not to HUUUGE

#### NEVER REQUEST CODE REVIEW BEFORE THIS

![](https://media.giphy.com/media/xT5LMA4nf7FyUVGZUY/giphy-tumblr.gif)

### Who should be reviewing?

Code owner(s).

Managers (Team Leaders).

Someone from another team.

Including and especially Juniors.

### After receiving comments

Fixes in new commits, prefixed **[PR-FIX]**.

Don't try to solve everything at once.

Be responsive and notify after fixing.

Have patience when elaborating.

Don't guard your code with your ego.

If you disagree strongly, consider giving it a few minutes before responding.

----

## The reviewer

![](https://media.giphy.com/media/Qw4X3FPbL62C9dvcKxq/giphy.gif)

#### Reviewers

Guards the commit history.

Are **NOT** responsible to test the code.

Should response within a logical time, or ping the reviewee to opt out of the review

### The review process

Read the pull request title and body to see that you get the need and value of the pull quickly.

Validate sane git commits.

Validate CI checks are passing.

#### NEVER REVIEW CODE BEFORE THIS IS DONE

### Actually reviewing code

Review commit by commit to get the story of the change.

Always comment on lines in diff view, not in general discussion at the pull request page.

### Nitbitting VS Bikeshedding 1/2

Comment on all that gets your attention, including typos, However, Don't lose sight on what the pull requests actual value.

Ask in a polite way if you need elaboration.

Use Emoji!!1.

### Nitbitting VS Bikeshedding 2/2

You can comment on things that weren't changed in the current pull request, don't block because of it.

Never **SCREAM IN CAPS** (unless pun).

**MANNERS MAKETH MAN**.

### Code quality

Code smells.

DRY.

Immutability.

Functional.

Performance.

Testable.

Readable.

### Tests quality

Good vs Bad path.

🦆 Typing.

Black box.

Differentiate Unit VS Integration VS System.

Documents the code.

### Async vs in person

Don't forget, you can do the review in person.

A face 2 face review can surface surprises.

![](https://media.giphy.com/media/26DNdV3b6dqn1jzR6/giphy.gif)

## Approve / Block / Comment

### Commenting 

Whilst it might be very polite only to comment and not blocking / approving, you need to take a stand, especially as the main reviewer.

![](https://media.giphy.com/media/y65VoOlimZaus/giphy.gif)

### Blocking

You **SHOULD** block the pull request if there's anything that's a blocker in your opinion.

State what is the blocker explicitly.

![](https://media.giphy.com/media/njYrp176NQsHS/giphy.gif)

Just don't be a douche about it.

![](https://media.giphy.com/media/ptDRdwFkFVAkg/giphy.gif)

### Approving

Ensure that you agree that code provide the value that satisfies the need of the pull request, with the high standards you would set for yourself.

![](https://media.giphy.com/media/kRXnZwKrPTwVq/200w_d.gif)

### NEVER EVERZ APPROVE WITHOUT APPROPRIATE GIF

![](https://media.giphy.com/media/3o72F8t9TDi2xVnxOE/giphy.gif)

----

### Yay, you got those sweet ✅s!!1

![](https://media.giphy.com/media/JxY27bgJhvpf2/giphy.gif)

### AND DAT GIF 

![SEALZ1](https://media.giphy.com/media/13zeE9qQNC5IKk/giphy.gif)

### DAT 2

![SEALZ2](https://media.giphy.com/media/B86lxbrMSZ0SQ/giphy.gif)

### Cleanup

Squash those dangling `[PR-FIX]` commits into the logical commit they belong.

Fetch `master` and rebase one last time.

Wait for CI (you shouldn't be able merge without it anyhuze).

---

## Merge away!

#### Delete the freaking branch after it's merged

Here's a sweet git alias for ya

```bash
[alias]
mic-drop = "!f() { 
       WANTED_BRANCH="${1}"; 
       echo "Cleaning up ${WANTED_BRANCH} like a boss!"; 
       git branch -d "${WANTED_BRANCH}";
       git push origin ":${WANTED_BRANCH}"; 
       }; f"
```

![](https://media.giphy.com/media/DfbpTbQ9TvSX6/giphy.gif)

#### Cheers and happy reviewing!

![](https://media.giphy.com/media/11RgbBSgomKx6o/giphy.gif)
