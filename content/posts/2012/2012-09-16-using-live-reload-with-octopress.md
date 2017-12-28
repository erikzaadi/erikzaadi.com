---
title: "Using Live Reload with Octopress"
date: 2012-09-16
comments: true
categories:  [blog, octopress]
---

Live Reload is an awesome Mac app and browser extension which reloads your browser automagically when editing a file.
Needless to save, it's a bliss, never to `{CMD,ctrl} + R` again.

For those of us who are Mac less, the App is of course not available.
Ruby to the rescue!

Install the LiveReload browser extension, see [long explanation](http://feedback.livereload.com/knowledgebase/articles/86242-how-do-i-install-and-use-the-browser-extensions-).

Edit `Gemfile` and add the following two lines:

```ruby
source "http://rubygems.org"

group :development do
  ...
  gem 'guard'
  gem 'guard-livereload'
end
```

Create a `Guardfile` with the following content:

```ruby
guard 'livereload' do
  watch(%r{public/.+\.(css|js|html)})
end
```

Open two terminal sessions (or panes if you're a champ using **TMUX**):

`rake generate && rake watch`

`guard`

Open your browser and press the LiveReload icon, and voila! You're set!
