---
title: "Sane Versioning in nodejs"
date: 2017-12-09T21:00:16+02:00
draft: false
description: "taming the version field in package.json"
tags: ['node.js', 'ci', 'github']
---

## node.js packaging

[node.js](https://nodejs.org) and `npm` have been through a lot since I started using them.
From whether or not to commit dependencies (THE HORROR) to git, to slow installations, you name it.

One of the most horrific atrocities for me has always been the fact that the version is hardcoded in the file `package.json`.

!['Whyyyz'](/images/why-hardcode.jpg)

It has always peskered me that it's not simply taken from a git tag, like sane languanges do.

However, since it's the common practice, and besides annoying me, it didn't block anything important enough, I never really did something about it until recently.

## ALAS, The need emerged

At [BigPanda](https://bigpanda.io), all our node.js services are created as an artifact as a part of the CI process, to speed up deployment time.

In addition, the node.js libraries are precompiled and _"dumbed down"_ using babel so they can be used using any node.js runtime that might need them, then packaged as an artifact (npm package) to be downloaded as a dependency.

This has worked good for a while, but it creates one limitation, to release a feature (merge a feature branch), you need to create an additional commit just for bumping the version in `package.json`.

Whilst this might not look like an issue, it prevents something extremely useful, and that's blocking merges until reviewed in [Github](https://github.com) pull requests.

This finally annoyed us enough to solve the issue (no more cowboy merges), and here's how we solved it.

## The solution

In each node.js library or service, the `package.json` contains the version `0.0.0`, which is the _"dev"_ version.

!['Take package.json to /dev/null'](/images/take-package-json-to-dev-null.jpg)

At the CI build, before creating the artifact to be uploaded (service or npm package), we bump the `package.json`'s version with latest git tag, using the following command:

```bash
npm version --no-git-tag-version $(git describe | cut  -c 2- | awk -F \- '{print $1};')
```

!['Bash to the rescue!'](/images/here-i-bash.jpg)

This might seem a bit magic, but it simply uses the latest git tag, which in our cases looks like this `vX.Y.Z`, where `X` is the major, `Y` is the minor and `Z` is the pebble (Semver style).

The `--no-git-tag-version` parameter makes `npm` only change `package.json`, without adding a tag or a commit for the bump.

This means that each service and library's artifact includes correct version in the archived `package.json`.

_Unt Viola!_ No extra commit to bump the version, and we can make sure by using Github's protected branches feature, that no merges are done without review (and tests).

The only small issue left is at dev time, where our devs need to do `git describe` to se what version they're on, but that's a no brainer, and solved through process.

## But that's not the standard?!?!

Well yes, you are right, that's not how it's done in node.js, it's better.

!['Thug Panda'](/images/panda-deb.jpg)
