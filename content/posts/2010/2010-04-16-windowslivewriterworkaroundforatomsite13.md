---
date: '2010-04-16'
slug: windowslivewriterworkaroundforatomsite13
status: publish
title: Windows Live Writer Workaround for AtomSite 1.3
wordpress_id: '21'
comments: true
categories:
- AspdotNETMvc
- aspnetmvc
- AtomSite
- Blog
---

[**UPDATE** - _Available for version 1.4 as well, see post_ [here](http://erikzaadi.com/blog/2010/05/16/WindowsLiveWriterWorkaroundForAtomSitePlugin14.xhtml)]

In continuous to an [old series](http://erikzaadi.com/blog/2009/12/06/BlogMigrationPart4ConnectingWindowsLiveWriterToTheAtomSiteBlog.xhtml) about migrating from Blogger to [AtomSite](http://atomsite.net), I came up with a workaround/solution that allows you to connect Windows Liver Writer to the [AtomSite](http://atomsite.net) blog.

I've been asked a couple of times to supply the solution, so I thought I'd publish it here for more easy access:

[WLWWorkaround.zip](http://demos.erikzaadi.com/atomsite/1.3/WLWWorkaround.zip)

Read the included `README` file for specific instructions..

If you want an easier access to the workaround than clicking in the address mentioned in the `README`, you can add the following to your `service.config`, I added it `AdminSettingsEntireSite"=>"settingsRight"

```xml
<svc:include
 name="LiteralWidget">  
    &lt;div class="widget settings area"&gt;  
    &lt;h3&gt;Windows Live Writer Workaround&lt;/h3&gt;  
    &lt;a href="/Admin/WLWWorkaround"&gt;Activate/Disable&lt;/a&gt;  
    &lt;/div&gt;  
</svc:include>  
```

Small disclaimer, this has been tested on [AtomSite](http://atomsite.net) 1.3 only..

Enjoy!

Erik
