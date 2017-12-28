---
date: '2009-10-20'
slug: jqueryconsoleplug-in
status: publish
title: jQuery Console Plug-in
wordpress_id: '36'
comments: true
categories:
- jQuery
- JQueryPlugins
---

#### **Prelude**

A typical scenario for me when I start a new web site, is to include JavaScript snippets from previous sites.

I usually get to a stage where need to solve problem that think I’ve solved before.      
Then, after a dark era for about 5 minutes of trying to actually remember when and where the solution is, I copy it to the new site.

Each time I keep telling myself that I need to create some kind of template for those typical snippets I always end up adding.

I wrote this [jQuery](http://jquery.com) plug-in since it’s one of the more common snippets I kept using.

Every web developer out there is familiar with the amazing [FireBug](http://www.getfirebug.com/) plug-in for FireFox, and probably also with the great logging features such as :

```javascript
console.log('something to log');  
```
  
This is a great feature for debugging your JavaScripts, in fact, it’s a real life saver.
As you can’t really leave the FireFox specific syntax to throw errors in say… IE6, you’d usually end up writing something like this in your project :
  
```
function LogToConsole(MessageOrObject){  

    if (typeof(window['console']) != 'undefined'){  

        console.log(MessageOrObject);  

    }  

}  
```  

Now that’s fine, but it limits you to debugging only in Firefox, which of course is never enough.      
Other browsers also have this feature, however, some with slightly different syntax. 
 

Chrome’s JavaScript debugger is quite useful (_Ctrl + Shift + J_), and it also supports console.log.       
So does Safari’s Developer (Which you need to enable in Settings –> Advanced, then _Ctrl + Alt + I_).       
Surprisingly enough, even Internet Explorer 8’s developer (_F12_) uses the same syntax.       
Opera’s DragonFly (Tools –> Advanced –> Developer Tools) however use a totally different syntax :

```  
opera.postError({someLabel:'someValue'});  
```  

The console object also exposes several more helpful functions for debugging, such as console.error, console.trace etc.      
These extra functions are not yet supported in a standard way in all browsers unfortunately.

#### So what does this plug-in do? 

Simply put, it enables you to do safe, cross browser logging to the console.

**Examples:**

To log any object to the console:

```
$.Console.Log('message',['dsad','dasdas'],{orJSON:'312'});  
```

Or, for debugging:

```
$.Console.Debug('message',['dsad','dasdas'],{orJSON:'312'});  
```
 
To log a selected element(s), this time using the `Info` function if available :
  
```
$('selector').Console($.Console.functions.Info)   
```
 
Here’s a list of all functions available in the $.Console.functions :

  * Log 
   
  * Trace 
   
  * Debug 
   
  * Info 
   
  * Warn 
   
  * Error 
   
  * Dir 
   
  * DirXML 
   
  * Group 
   
  * GroupCollapsed 
   
  * GroupEnd 
   
  * Time 
   
  * TimeEnd 
   
  * Profile 
   
  * ProfileEnd 
   
  * Count      

     

  
 

Please see [http://getfirebug.com/console.html]( http://getfirebug.com/console.html) for more details on each function.

 

#### 

 

#### Where can I get it?

 

[Project Page](http://erikzaadi.github.com/jQueryPlugins/jQuery.Console/) : [Sample Page](http://erikzaadi.github.com/jQueryPlugins/jQuery.Console/Sample/) : [Fork the project at Github](http://github.com/erikzaadi/jQueryPlugins)

 

Enjoy,

 

Erik

 

