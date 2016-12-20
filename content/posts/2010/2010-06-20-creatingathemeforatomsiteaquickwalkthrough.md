---
date: '2010-06-20'
layout: post
slug: creatingathemeforatomsiteaquickwalkthrough
status: publish
title: Creating a theme for AtomSite, a quick walkthrough
wordpress_id: '17'
comments: true
categories:
- AtomSite
- Blog
---

**Prelude** : Reading through[_http://atomsite.net/info/Themes.xhtml_](http://atomsite.net/info/Themes.xhtml) might help if anything here is not understood.

Small disclaimer: I'm under no circumstances a good designer, hence the "estetics" of the sample..

It might be needless to say, but I do recommend having a local copy of [AtomSite](http://atomsite.net) available to test the theme until it's mature..

### Getting Started:


Let's say we want to create a template called _"Sample"_:
	
  1. Create the folder _"sample"_ in themes

	
  2. Copy the _"settings.xml"_ from _"themes/settings/settings.xml"_ and rename it to _"sample.xml"_
	
  3. Open up the xml, and change the following tags to the following values:

Tag Name
Tag Value
atom:title
Sample Theme
atom:content
This is the Sample Theme's description…
atom:id
tag.atomsite.net,2008:themes,sample
	
  4. When finishing up the theme, remember to change the screenshot,
homepage, author, contributor and dates (published, updated).

**Note: _Not needed in this stage.._**

	
  5. Log in to your Admin Dashboard, and choose the Sample Theme, and then open up your home page..

	
  6. You should see a very simple (yet still structured) text only theme: ![](/images/Image_thumb.png)

	
  7. Download this file : ![](/images/Background2.jpeg)

    (Shamelessly generated at [http://bgpatterns.com/](http://bgpatterns.com/)), and save it as _"img/sample/background.jpg"._ (create the folder)

  8. Create the file _"sample.css"_ in _"css/sample/"_ (again, the folder needs to be created)

    Add the following to the created CSS file:

```css
body {
    background : transparent url('../../img/sample/background.jpg') repeat fixed;
}
```

  9. Refresh the browser with the home page, and _voila!_ , you get a new lovely background. 

**_So what happened here?
_**[AtomSite](http://atomsite.net)_automagically_ picks up the CSS file, since it's named the same as the theme.

_Notice the path to the image_, this is very important, since you'd typically only use your own images, and the best place to put them is in your themes designated image folder.

Ok, You're a CSS Ninja, you know how you could "re-skin" everything with CSS only, which is fully possible, since [AtomSite](http://atomsite.net) adds id's to the body per page and component.

My CSS Fu can be disputed, and from what I've experienced so far, I've usually needed to alter the HTML markup to generate the desired result.

  10. Copy the file _"themes/default/Site.Master"_ to _"themes/sample/"_ .
	
  11. Edit the copied _"Site.Master"_ and add :

```html
<h3>I can has my custom sub sub title!</h3>
<h4>Even with dynamic content (Today == <%= DateTime.Now.ToString() %>)!</h4>
```

right after :

```html
<h1><a href="/"><%= Model.Workspace.Title %></a></h1>
<h2><%= Model.Workspace.Subtitle %></h2>
```

  12. Refresh, and you'll see the new sub sub, and sub sub sub titles (pun intended).

### YUI or not to YUI


[AtomSite](http://atomsite.net) uses the YUI CSS framework reset.
Although it's a very powerful framework, I have to admit that I personally prefer writing my own or using [blueprintcss](http://www.blueprintcss.org/).
To disable the YUI framework in your theme, remove the following line from the file _"Site.Master"_ in your theme folder:

```html
<link rel="stylesheet" type="text/css" href="<%= Url.StyleHref("reset-fonts-grids-2.7.0.css") %>" />
```

### When using [AtomSite](http://atomsite.net) in a subfolder

Change the following in the _"Site.Master"_ to fix the link in the header:

To Find
Replace with

```html
<h1><a href="/"><%= Model.Workspace.Title %></a></h1>
<h1><a href="<%= Url.Content("~/)"><%= Model.Workspace.Title %></a></h1>
```

### Testing

Nothing can replace good testing, here's the usual list of tests I run to ensure that the theme is ready

**Very Important:**_always check each task both authenticated as an admin, as a user and not authenticated!_

  1. Master Page

	
    1. General layout

	
    2. Navigation

	
    3. Search bar

	
    4. Footer

	
    5. Sidebar

	
  2. Blog Home

	
  3. Blog Listing

	
  4. Blog Entry

	
  5. Blog Comments (View)

	
  6. Blog Comments (Adding)

	
  7. Sidebar Widgets


Test the theme in all browsers (Chrome, Opera, Firefox, Safari), and even non browsers as IE..


### ThemeExtensions


I've written a plugin to [AtomSite](http://atomsite.net) which exposes Html and Url Helpers that saves some time when developing / porting a theme.

Example:

```html
<ul>


<% foreach (var status in Model.Statuses){ %>
<li><span class="entry">
<%= Html.ThemeExtensions().Social.MakeTwitterContentClickable(status.Text)%>
<a class="date" href="http://twitter.com/<%= Model.Statuses.First().User.ScreenName %>/statuses/<%= status.Id %>" rel="nofollow"><%= Html.DateTimeAgoAbbreviation(status.CreatedAt)%></a></span>
</li>
<% } %>
</ul>
```
You can download or fork the source code [ here](http://github.com/erikzaadi/AtomSitePlugins/tree/master/src/ThemeExtensions/).

### More samples

The source code for [AtomSiteThemes](http://atomsitethemes.erikzaadi.com/) might help, besides the [AtomSite](http://atomsite.net) code there, it also includes all custom themes I've ported from Wordpress so far, grab it [here](http://github.com/erikzaadi/atomsitethemes.erikzaadi.com).

Sample theme from this post : [Preview](http://atomsitethemes.erikzaadi.com/ThemeSwitcher/ChangeTheme?ThemeName=Sample) | [Download](http://atomsitethemes.erikzaadi.com/ThemeSwitcher/Download?ThemeName=sample)

If you found this interesting, [Porting Wordpress themes to [AtomSite](http://atomsite.net)] will be available soon..

Enjoy!

Erik
