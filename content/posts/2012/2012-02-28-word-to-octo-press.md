---
title: "mv {word,octo}press"
date: 2012-02-28
status: publish
comments: true
categories: [Personal, Blog, BlogMigration]
---

After my wordpress blog was hacked twice, and I got a warning from google that I host malware (!), I decided that enough is enough, time to ditch Wordpress and hope never to see php code again.

I managed to resist the urge to roll my own blog engine (*haven't we all been there?*), and decided to use [octopress](http://octopress.org).

After being victorious over ruby and rvm who thought it'd be hilarious to make me go crazy while making [earthquake](https://github.com/jugyo/earthquake) work, I thought I might give octopress a shot.

It took me one late night hack to get everything up and running.

I used [exitWP](https://github.com/thomasf/exitwp)'s script to generate markdown posts.
Then I did some sed magic to add comments

```yaml
comments: true
``` 

to the yaml head of all post files.

Since I've got all my images hardcoded to wp-content (for now), I simply added that folder to the source folder.

I imported all my comments to [disqus](http://disqus.com) using the same WXR export file I used to migrate with exitWP, and the comments where available after a few hours.

I changed the permalinks format a bit to keep the same url scheme as wordpress for the posts, and changed the category scheme to fit as well:

```yaml
permalink: /:year/:month/:day/:title/
#permalink: /blog/:year/:month/:day/:title/
...
category_dir: category
category_title_prefix: "Category: "
```

For a more thourough migration guide try [Pavan Podila](http://blog.pixelingene.com/2011/09/switching-to-the-octopress-blogging-engine/) or [Vito Botta](http://vitobotta.com/how-to-migrate-from-wordpress-to-jekyll/).

I still have some more work cleaning up the posts, adding correct (and awesome) code highlighting, redo the theme etc.

But hey, that's exactly why I like octopress, so much enjoyable stuff to hack on :)
