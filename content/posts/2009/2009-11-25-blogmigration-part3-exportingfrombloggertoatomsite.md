---
date: '2009-11-25'
layout: post
slug: blogmigration-part3-exportingfrombloggertoatomsite
status: publish
title: Blog Migration - Part 3 - Exporting Posts From Blogger To Atomsite
wordpress_id: '32'
comments: true
categories:
- AtomSite
- Blog
- BlogMigration
---

Previous Parts : [1](http://erikzaadi.com/blog/2009/11/17/BlogMigrationPart1SettingUp.xhtml), [2](http://erikzaadi.com/blog/2009/11/17/BlogMigration-Part2-TemporaryPages.xhtml)

Blogger are awesome in many ways, but if there's one feature missing, it's a way to import/export to other blog engines.

[BlogML](http://en.wikipedia.org/wiki/BlogML) is a standard that several other blog engines are starting to support.
 
[AtomSite](http://atomsite.net) supports BlogML integration from version [1.3](http://atomsite.net/blog/2009/09/21/Release13.xhtml) (**Note:** This is not the version shipped in the web platform installer).

## I used a superb tool called [BlogExporter](http://sourceforge.net/projects/blogexporter/), which exported all of my posts, comments and tags from my Blogger account to a nice little XML file.

Unfortunately, this XML file can not be imported as is to AtomSite, it needs a bit of massaging..

I exported the default blog that ships with the installation of AtomSite, to a BlogML XML file, and then compared the with the result from BlogExporter.

I noticed that a couple of tags where missing regarding the author of the blog, namely the email and title:

```xml
<authors>  
    <author approved="true"  
        created="2009-11-04T17:39:28.1678914+02:00"  
        email="my.mail@gmail.com"  
        id="Erik Zaadi"  
        modified="2009-11-04T17:39:28.1678914+02:00">
    <title>Erik</title>  
    </author>  
</authors>  
```

The `<extended-properties />` tag needed to be replace with the following:

```xml
<extended-properties>  
    <property>  
        <Key>CommentModeration</Key>  
        <Value>Authenticated</Value>  
    </property>  
    <property>  
        <Key>SendTrackback</Key>  
        <Value>No</Value>  
    </property>  
</extended-properties>  
```

Altering those values in the XML file allowed me to import the posts to AtomSite smoothly.
Stay tuned for the next post about connecting AtomSite to Windows Live Writer..

Erik
