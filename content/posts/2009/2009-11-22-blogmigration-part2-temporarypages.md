---
date: '2009-11-22'
layout: post
slug: blogmigration-part2-temporarypages
status: publish
title: Blog Migration - Part 2 - Temporary Pages
wordpress_id: '33'
comments: true
categories:
- AtomSite
- Blog
- BlogMigration
---
Previously : [Part 1 - Setting up](http://erikzaadi.com/blog/2009/11/17/BlogMigrationPart1SettingUp.xhtml)
				
After getting my self my little virtual corner on the webospere,  it was time to get some content up before getting all the final sites up.

### Steps:
				
  1. "No 404 for me"

    A small "Under construction" [page](http://demos.erikzaadi.com/misc/firstRoot/) ,with a typical 90's under construction gif look

  1. Linking my existing (sub)sites: I added two CNAME records: 

    Blogger Account  : http://blogger.erikzaadi.com =>
    http://erikzaadi.blogspot.com

    Project Pages : http://projects.erikzaadi.com =>
    http://erikzaadi.github.com

  1. Setting up the root of the site:

    I started to throw together a small asp.net mvc project for the [root](http://demos.erikzaadi.com/firstMVCRoot) of the site, both to test the hosting server's MVC and DB capabilities.  

    Besides overdoing the grey gradient theme to death, I think I exaggerated a bit with the fly thing at the [404](http://demos.erikzaadi.com/firstMVCRoot/NonExistingURL) and [ErroraPage](http://demos.erikzaadi.com/firstMVCRoot/Home/ThrowOne).
			
  1. Getting the blog working

    I installed [AtomSite](http://atomsite.net) on http://blog.erikzaadi.com and started playing around a bit with the theme.  

    Again, as you can see, I'm still with the grey gradient look (will I ever grow tired of it?).


Stick around for the next post, which will be about migrating my blogger posts into the AtomSite powered blog.

Cherios,
Erik
