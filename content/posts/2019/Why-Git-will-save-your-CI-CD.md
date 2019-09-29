---
title: "Life is short, make your CI blazing fast"
date: 2019-09-29T11:12:38+03:00
draft: false
description: "The short and simple tale of how a commit SHA-1 can save you time and trouble"
tags: ["CI", "CD", "continuous integration", "continuous deployment", "git"]
---

# Rebase your CI

I've seen A LOT of continuous integration implementations, both while mentoring CI and during my day work.

One of the simplest but most important of the [HOLY 11 CI COMMANDMENTS](https://martinfowler.com/articles/continuousIntegration.html) is:

> Keep the build fast

And yet, the top mistake I keep seeing all over:

### Wasting time

![Wasting Time](https://media.giphy.com/media/lcjWzvc9po5Og6eV4V/giphy.gif)

## Things we keep doing wrong

* Long build times due to lack of simple caching
* Cumbersome "SAFE GATES" that involves humans (!)
* Not paralleling where possible

And the list goes on and on.

### HOWEVER

Not all is lost, I'm going to share with you a simple small change of mindset that will improve your CI/CD builds.

Another good old nugget of wisdom is Kent Beck's [DRY](https://martinfowler.com/bliki/BeckDesignRules.html) design principle.

If we think about that in a CI point of view, you'll see that _typically_ , people are running the same tests on their feature branches as in `master` (or for those who still do `develop` as well).

This means that for the same set of code, without any changes, we violate the DRY principle by assuming that the build is mutable for the same set of changes.

#### HMM

![](https://media.giphy.com/media/kPtv3UIPrv36cjxqLs/giphy.gif)

Let's rethink that, and what could cause such despicable mutable builds:

* There's no way to actually determine that nothing has changed
* Our build system is mutable by design, each build might break due to weak dependencies or simply not having immutable infrastructure for your CI jobs (hello `Exception: out of disk space` my old friend).

### Okkkk, well?

Whilst the second bullet is something harder to solve (or just move to one of the SAAS CI services out there), the first is incredibly easy.

**NOTE:** _I'm going to assume that you're part of this century and working with Git._

## Enter Git Rebase

If you're working with [Git Rebase](https://git-scm.com/docs/git-rebase), _and you should_, there is no difference between the code you're testing in your feature branch and `master`.

Simply because it's the same Git Commit SHA-1.

Git has already done all the hard work of uniquely identifying your set of changes.

### WHOA

![](https://media.giphy.com/media/1TjuPOvVALy4o/giphy.gif)

Thus, if your CI build takes X seconds, you can shave off the same X seconds from your `master` build.

### WHAT, I TOLD YOU IT WAS SIMPLE

![](https://media.giphy.com/media/iKHWBVBR3sevcSRiLZ/giphy.gif)

## To recap

By using Git Rebase, you can make your CI pipeline leaner, but simply not repeating yourself when not needed.

## Here's an example

The example below is using [Travis CI](https://travis-ci.com), but it can just as easy be any other CI platform.

### Before

```yaml
sudo: false
dist: trusty
group: travis_latest
language: node_js
cache:
  directories:
  - node_modules
before_script:
- npm install --no-optional
script:
- npm test
before_cache:
- npm prune --production --no-optional
before_deploy:
- echo "Whatever preparations you do here such as tar balling etc"
deploy:
- provider: yourprovider
```

This will run for whatever push you are doing, including pushing the same commit that was already tested to master.

### After

```yaml
sudo: false
dist: trusty
group: travis_latest
language: node_js
cache:
  directories:
  - node_modules
stages:
  - name: Build, publish and test
    if: (tag IS blank) AND NOT (branch = master)
  - name: Test
    if: NOT (tag IS blank) OR (branch = master)
  - name: Build and publish
    if: NOT (tag IS blank) OR (branch = master)
jobs:
  include:
  - &build-and-publish
    stage: Build and publish
    name: Build and publish
    if: type = push
    sudo: false
    script: echo "Whatever preparations you do here such as tar balling etc"
    install: true
    deploy:
    - provider: yourprovider
    env:
    - CACHE_NAME=prod
  - &test
    stage: Test
    name: Run tests
    sudo: false
    install: true
    before_script:
    - npm install --no-optional
    - npm prune
    script:
    - npm test
    env:
    - CACHE_NAME=test
  - <<: *test
    stage: Build, publish and test
  - <<: *build-and-publish
    stage: Build, publish and test
```

This ensures that tests will only run on feature branches and not on `master` or tags.

In addition, the cache is separated between developer dependencies and production dependencies to speed things up a bit more.

## Gimme them numbers

NodeJS projects: Removed ~3 minutes from the master build.

Scala projects: Removed around ~14 minutes (!).

For simplicity, I did not include the entire scripts, but several other changes besides just not running tests were made in the same mindset:

* Don't rebuild docker images, only add tag
* Don't recreate artifacts when not needed


#### Cheers.
