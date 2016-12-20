---
date: '2009-08-21'
layout: post
slug: jquerylateloaderplugin
status: publish
title: jQuery Late Loader Plugin
wordpress_id: '41'
comments: true
categories:
- jQuery
- JQueryPlugins
---

#### **Prelude**

 
When enhancing dynamic pages (no matter the server side language behind), [jQuery](http://jquery.com) is more than helpful.       
Especially since there’s loads of [jQuery plugins](http://plugins.jquery.com) out there, saving so much time and effort.       
When using javascripts in reoccurring user controls, controlling the added javascripts and css files from the server language is possible (to prevent duplicate loading), but in many cases adds bloated and hard to maintain code.       
Keeping the includes only in the markup is easier to maintain (IMHO), however might cause unneeded http requests to your scripts and css files, especially if you have a page with multiple reoccurring user controls.

 

#### **The Plugin**

 

This plugin will allow you to include scripts ands css files dynamically, with success and failure callbacks.

 

#### Usage

```javascript
$.LateLoader =   

{  

LoadScriptOrCSS:   

    /*  

         Loads a javascript/css from the passed url if it wasn't previously loaded  



         The parameter can either be a string with the wanted url( then the default  

         params are used (See Defaults for more details)), or an option object   

         URL -> relative or absolute URL to your javascript/css   

      */ 

        IsScriptOrCSSLoaded:  

        /*  

             Returns true|false if a javascript/css is already loaded  

             (via LoadScriptOrCSS)  



             Parameters :   

             URL-> relative or absolute URL to your javascript/css   

             Type->'js' or 'css' (defaults to 'js')  

          */ 

        GetLoadedScriptOrCSSs:   

        /*  

             Returns an array of all loaded scripts (object with 2 arrays, css and js)  

          */ 

        GetLoadedScriptOrCSSsByType:  

        /*  

             Returns an array of all loaded scripts/css according to the passed type  



             Parameter :   

             Type->'js' or 'css'   

          */ 

        PluginDefaults:  

        {  

ArrayDataKey: "LateLoaderDataKey",   

                  //Unique key used to identify the jQuery Data collection  

                      ElementToAttachDataTo: "body",   

                  //DOM object that hosts the jQuery Data collection  

                      RemoteTimeout: 1500   

                      //MS of timeout to wait for a remote script..  

                      },  

    Defaults:  

    {  

URL: **null**,   

     //Will be filled in by LoadScriptOrCSS's parameter  

         Type: 'js',   

     // 'js' or 'css' (defaults to 'js')  

         LoadedCallBackFunction: **null**,   

     // Called when the javascript/css is loaded (default is null)  

         ErrorCallBackFunction: **null**   

         // Called when an error occurs (default is null)  

         }  

}  
```
  


  


 

#### **Where can you get it?**

 

[Main project page](http://erikzaadi.github.com/jQueryPlugins/jQuery.LateLoader/) | [Sample Page](http://erikzaadi.github.com/jQueryPlugins/jQuery.LateLoader/Sample/) | [Wiki](http://wiki.github.com/erikzaadi/jQueryPlugins/jquerylateloader) | [Source](http://github.com/erikzaadi/jQueryPlugins/tree/master)

 

#### **What’s missing in it?**

 

Detecting remote css files that are missing are so far only supported in IE      
The plugin should scan the existing scripts / links includes as well as the data loaded by the plugin

 

#### **Got suggestions?**

 

I’d love to hear any feedback!

 

Enjoy,

 

Erik

