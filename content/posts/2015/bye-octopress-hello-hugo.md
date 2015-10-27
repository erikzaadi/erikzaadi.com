---
date: 2015-10-25T22:06:43+02:00
title: Bye Octopress, Hello Hugo
description: "Yet another blog platform migration"
categories: [blog, octopress, hugo]
---

After suffering from write block, heavily influenced by octopress super fast load time, I moved this blog to [hugo](https://gohugo.io/).

Here's some comparisons:

### Setting up:

Octopress:

```
gem install bundler
bundle install
Fetching gem metadata from https://rubygems.org/...........
Fetching version metadata from https://rubygems.org/...
Fetching dependency metadata from https://rubygems.org/..

Installing rake 0.9.2.2
Using RedCloth 4.2.9
Installing chunky_png 1.2.5
Installing fast-stemmer 1.0.1 with native extensions
Installing classifier 1.3.3
Installing fssm 0.2.9
Installing sass 3.2.9
Installing compass 0.12.2
Installing directory_watcher 1.4.1
Installing haml 3.1.7
Installing kramdown 0.13.8
Installing liquid 2.3.0
Installing syntax 1.0.0
Installing maruku 0.6.1
Installing posix-spawn 0.3.6 with native extensions
Installing yajl-ruby 1.1.0 with native extensions
Installing pygments.rb 0.3.4
Installing jekyll 0.12.0
Installing rack 1.5.2
Installing rack-protection 1.5.0
Installing rb-fsevent 0.9.1
Installing rdiscount 2.0.7.3 with native extensions
Installing rubypants 0.2.0
Installing sass-globbing 1.0.0
Installing tilt 1.3.7
Installing sinatra 1.4.2
Installing stringex 1.4.0
Using bundler 1.10.6
Bundle complete! 15 Gemfile dependencies, 28 gems now installed.
Use `bundle show [gemname]` to see where a bundled gem is installed.
```


Hugo:

```
brew install hugo
mkdir themes
git clone https://github.com/digitalcraftsman/hugo-cactus-theme themes/cactus
```


### Generating:

Octopress:

```
time bundle exec rake generate
## Generating Site with Jekyll
unchanged sass/screen.scss
Configuration from /path/to/erikzaadi.com/_config.yml
Building site: source -> _site
Successfully generated site: source -> _site
bundle exec rake generate  10.31s user 1.14s system 99% cpu 11.527 total
```

Hugo:

```
time hugo
0 draft content
0 future content
83 pages created
92 paginator pages created
70 categories created
in 266 ms
hugo  0.66s user 0.08s system 229% cpu 0.321 total
```

I can't measure how much faster it is while iterating on a blog post using `watch`, but it's simply frictionless with Hugo, livereload included, and blazingly fast.

I also took the opportunity to go through all of my old blog post and clean most of them up, keeping them as pure markdown as possible. No custom tags and such, so that if I'd want to move to [metalsmith](http://www.metalsmith.io/) or any other static site generator, the move will be as smooth as possible.

The deployment is still done using `s3-cli` which I already [blogged about](/2015/04/27/s3cmd-is-dead-long-live-s3-cli/).
