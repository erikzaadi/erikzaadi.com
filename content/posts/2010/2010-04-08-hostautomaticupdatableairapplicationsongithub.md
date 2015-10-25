---
date: '2010-04-08'
layout: post
slug: hostautomaticupdatableairapplicationsongithub
status: publish
title: Host Automatic updatable Air applications on Github
wordpress_id: '22'
comments: true
categories:
- Air
- Github
---

For the impatient, check out the [demo](http://github.com/downloads/erikzaadi/AirOnGithub/AirOnGithub-v1.0.air) | [source](http://github.com/erikzaadi/AirOnGithub)..

##### Intro

Creating desktop applications in [Air](http://www.adobe.com/products/air/) with html and JavaScript is a joy for any web oriented developer.
You get the same environment to work in, [jQuery](http://jquery.com) included, and the ability to create desktop based applications fast.
The only thing problem you encounter is the switch in concept of updating the desktop application with a new version.
It’s no longer as easy as updating the site, you need to get the user to download the update..

The good news is that Adobe has made it really easy to set up a workflow where the application automatically updates itself.      
All you need is a web site to host the updated versions, a small xml describing the version, and [Air](http://www.adobe.com/products/air/) takes care of the rest.

 
There are some nice [Tutorials](http://www.adobe.com/devnet/air/ajax/quickstart/update_framework.html) available, and the [documentation](http://help.adobe.com/en_US/AIR/1.5/devappshtml/WS5b3ccc516d4fbf351e63e3d118666ade46-7ff2.html#WS9CD40F06-4DD7-4230-B56A-88AA27541A1E) is fairly good.       
You customize the update interface, localize and hook into almost every step in the update process.

However, for open source applications, affording a web site might be a bit out of the budget.

Here [Github](http://github.com) steps in to offer not only an affordable (free), but also reliable, fast and easy to manage solution.

What better way than to simply push the changes using [git](http://git-scm.com/) to [Github](http://github.com)?

##### So how is it done?

If you’re not a [Github](http://github.com) member, do [join](https://github.com/signup/free), it’s free and it’s great! 

Download/Clone/Fork the [example project](http://github.com/erikzaadi/AirOnGithub)

Open the directory updater and notice the following xml files:

`config.xml`:

```
<?xml version="1.0" encoding="utf-8"?>  
    <configuration xmlns="http://ns.adobe.com/air/framework/update/configuration/1.0">  
        <url>http://github.com/erikzaadi/AirOnGithub/raw/master/updater/update.xml</url>  
        <delay>2</delay>  
    </configuration>  
</xml>
```

`update.xml`:

```
<?xml version="1.0" encoding="utf-8"?>  
    <update xmlns="http://ns.adobe.com/air/framework/update/description/1.0">  
        <version>2.0</version>  
        <url>http://github.com/downloads/erikzaadi/AirOnGithub/AirOnGithub-2.0.air</url>  
        <description><![CDATA[  
This would be a good place to put release notes etc  
        ]]></description>  
    </update>  
</xml>

```


The [Air](http://www.adobe.com/products/air/) updater framework will open up the **config.xml** file in order to to get the url of **update.xml**, which includes version, description and most important, the url to the updated [Air](http://www.adobe.com/products/air/) file.

Whenever the framework recognizes that a new version is available, it’ll launch the updating process, downloading and applying the update.

Since [Github](http://github.com) are kind enough to expose such a wonderful api on their site, you can access the **update.xml** either on the master branch as I did, or on a special branch/tag preserved for the update mechanism.       
Furthermore, [Github](http://github.com) allows you to upload files to the download section, served by the cloud to ensure superfast speed.

If you want, you can even add a installer badge using [Github Pages](http://pages.github.com/).       
(Sample not included in the example mentioned before, see [demo](http://jqapi.erikzaadi.com/badge/) | [source](http://github.com/erikzaadi/jqapi/tree/master/air/badge/) for the [jQAPI](http://jQAPI.com) project as reference)

[Example Air file](http://github.com/downloads/erikzaadi/AirOnGithub/AirOnGithub-v1.0.air) | [Example Source](http://github.com/erikzaadi/AirOnGithub)

 
Enjoy!

Erik
