---
date: '2009-07-28'
slug: jqueryprintelementplugin
status: publish
title: jQuery Print Element Plugin
wordpress_id: '44'
comments: true
categories:
- jQuery
- JQueryPlugins
---

##### 
  **[UPDATE - Version released [1.0](http://erikzaadi.com/blog/2009/10/09/Update-JQueryPrintElementPluginVersion10Released.xhtml)]** 

Similar to those ["utilicous"](http://erikzaadi.com/blog/2009/07/21/JoyOfWritingUtilities.xhtml) moments are the "I got to write a jQuery plugin
that does this" moments..  

Had one of those a while ago, and the results were the jQuery Print
Element Plugin.  
For those of you that are not familiar with [jQuery](http://jquery.com/), I mentioned
it previously in an [early post](http://erikzaadi.com/blog/2009/05/14/NewBlogLayout.xhtml).

## So what does this plug-in do?

Well, as per the title, it sends a jQuery selected element to
the printer.  

So what's special about it?

Well, I saw a few existing plug-ins around (Kudos again to [PrintArea](http://plugins.jquery.com/project/PrintArea) and this [fellow](http://stackoverflow.com/questions/472951/how-do-i-print-an-iframe-from-javascript-in-safari-chrome) for the inspiration), but they lacked
the functionality I needed.  

And of course, I really wanted to write my first jQuery plug-in :-)

The usage is rather strait forward:

`$("selector").printElement();`

 
Which will caused the selected jQuery objects html to be sent
to the printer.  
  
There are two main modes you can use:

Print from :  


  1. Iframe (default, Pro: Hidden)
  2. Popup (Pro: shows the user a preview of what'll be
printed)  


For more info, and more options, have a look at the [Wiki](http://wiki.github.com/erikzaadi/jQueryPlugins/jqueryprintelement), or at the [official plug-in page at jQuery](http://plugins.jquery.com/project/printElement).  
Would love to hear any feedback, either here or at the [issues section](http://github.com/erikzaadi/jQueryPlugins/issues/labels/printElement)..  

Cheers,

Erik

