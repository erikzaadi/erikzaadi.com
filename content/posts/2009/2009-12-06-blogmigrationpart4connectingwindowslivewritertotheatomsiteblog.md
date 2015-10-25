---
date: '2009-12-06'
layout: post
slug: blogmigrationpart4connectingwindowslivewritertotheatomsiteblog
status: publish
title: Blog Migration – Part – 4 – Connecting Windows Live Writer to the AtomSite
  blog
wordpress_id: '31'
comments: true
categories:
- AtomSite
- Blog
- BlogMigration
---

Previous Posts : [1](http://erikzaadi.com/blog/2009/11/17/BlogMigrationPart1SettingUp.xhtml) | [2](http://erikzaadi.com/blog/2009/11/17/BlogMigration-Part2-TemporaryPages.xhtml) | [3](http://erikzaadi.com/blog/2009/11/25/BlogMigration-Part3-ExportingFromBloggerToAtomsite.xhtml)
			

This post took me a while to get together, it's actually the first blog post I'm writing from Windows Live Writer on this blog..

To be able to write and manage posts efficiently, you need to connect with a good desktop program, with offline capabilities such as preview, saving drafts etc.

[Windows Live Writer](http://get.live.com/writer/overview) is the perfect application for me, as unfortunately I don't get to spend much time on the Mac side of life..

For most [atomsite](http://atomsite.net) blog users, connecting Windows Live Writer to their blogs should be rather strait forward, if it doesn't work as per the [guide](http://atomsite.net/info/LiveWriter.xhtml), removing the
				`_"WindowsAuthenticationModule"_` at the `web.config` file (as explained per the [troubleshooting](http://atomsite.net/info/Troubleshooting.xhtml) guide) should get you started promptly..

However, in a imperfect world of shared hosting, you can not always control such settings, as they are locked by default by IIS on the root level (in the [applicationHost.config](http://learn.iis.net/page.aspx/124/introduction-to-applicationhostconfig/) file).

I tried to work around this problem with using different desktop blogging tools, and by trying to get my hosting provider to unlock the setting (Coming soon in a post, rather amusing
actually).

I downloaded the source for the atomsite blog engine, and started hacking away on their code, to find at least a viable workaround for this annoying problem.

It turns out that Windows Live Writer is actually making several requests to the blog, and not always sending the authentication details.

I managed to do a rather ugly hack that allows me to work with Windows Live Writer for now.

I'm still working on a better solution for this, as the solution I ended up with is not something usable for any other atomsite deployment.

If anyone is interested in the hack/solution <del>post a comment on this post, mail contact[at]erikzaadi[dot]com or simply drop me a tweet.</del> 

**[UPDATE] Download Details in [this post](http://erikzaadi.com/blog/2010/04/16/WindowsLiveWriterWorkaroundForAtomSite13.xhtml)**
                

Erik


		
