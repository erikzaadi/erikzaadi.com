---
date: '2009-10-27'
layout: post
slug: googleanalyticsdotnet
status: publish
title: Google Analytics.NET
comments: true
wordpress_id: '35'
---

#### Prelude [skip]

I’ve been using Google Analytics for a while now, both for this blog and my [projects site](http://erikzaadi.github.com), and as many others I think the service is great.

While creating my project site, I wanted to make sure that the site had graceful degradation, especially that the site would be accessible without javascript.      
This introduced a new problem for me, even though visitors with javascript disabled where able to see the site rendered, their visits where not tracked in Google Analytics.

I stumbled upon a solution by Remy Sharp (see [here](http://remysharp.com/2009/10/15/the-missing-stat-noscript)), in the form of a plugin written in PHP for the popular WordPress blog engine, and with his permission I ported it to a .NET solution.


#### So what does this project do? 

It generates a snippet that includes not only the regular Google Analytics script, but also a small `<NOSCRIPT>` tag with an image loaded from Google’s servers, with parameters about the current request.


#### The result:


[![gasample](http://lh6.ggpht.com/_yHiOsYmxDCc/Sua5rpmF3GI/AAAAAAAACBo/eZaJ_kUo0Kw/gasample_thumb%5B1%5D.png?imgmax=800)](http://lh5.ggpht.com/_yHiOsYmxDCc/Sua5qyU7FpI/AAAAAAAACBk/qPDcl1IZ3pI/s1600-h/gasample%5B1%5D.png)


The visitor with a javascript disabled browser is tracked, and appended with “[NOSCRIPT]” for easy identification in the dashboard.


#### Project Components

The project includes three basic components:

  
  1. Core Engine        
Generates the snippets, either separately (for the NOSCRIPT, and the script), or the entire snippet 
   
  2. ASP.NET MVC Html Helpers        
     

```html
<%= Html.GoogleAnalytics("UA-xxxxxx-x"/* Google Analytics Account ID */)%>  
``` 

   
  3. ASP.NET Web Forms        
     
```html
<GoogleAnalytics:GAControl ID="GAControlID" runat="server" GoogleAnalyticsID="UA-xxxxxx-x" />  
```

There’s also a small sample site, with both ASP.NET MVC and ASP.NET Web forms samples.

#### Where can I get it?

Visit the [project page](http://erikzaadi.github.com/GA.NET/) for more details.

Enjoy,

Erik
