---
date: '2010-11-28'
layout: post
slug: dynamic-pitfalls
status: publish
title: Dynamic Pitfalls
wordpress_id: '12'
comments: true
categories:
- AspdotNETMvc
- aspnetmvc
- CSharp
---

I'm working on an asp.net mvc 3 powered site (for my wedding actually!), where I decided to try out some new technologies I've been wanting to play with for a while.

The first technology is the combination of [EF 4.0](http://msdn.microsoft.com/en-us/data/ef.aspx) (AKA Entity Framework), and the new [SQL Server Compact 4.0](http://blogs.msdn.com/b/sqlservercompact/archive/2010/07/07/introducing-sql-server-compact-4-0-the-next-gen-embedded-database-from-microsoft.aspx), which is working nice so far, and hopefully I'll elaborate more in the matter in a future post.

The most important thing I wanted to test though was asp.net mvc 3 (RC), running on .NET 4, especially the usages of the `dynamic` keyword.

You can now pass dynamic values instead of the `ViewData` magic string dictionary, setting values on the page level, view level etc.

This introduces a blessed flexibility, and saves time.

Here's a small example where I used it:

```
public ActionResult Login(string ReturnUrl)  
    {  
        ViewModel.ReturnUrl = ReturnUrl;  
        ViewModel.LoginFailed = false;  
        return View();  
    }  
```

I have a method for `Login` on my controller, which get's the `ReturnUrl` from the authentication filter (AKA, if you visit a route that has the [Authorize] filter before logging in, you'll be redirected to the `Login` method, and the .Net framework appends the query string `ReturnUrl` to the request).

Peaches, now for the view:

```
@using (Html.BeginForm())  
{  
    <input type="hidden" name="ReturnUrl" value="@View.ReturnURl" />  
    <label>  
        @Html.TextBox("id") Password  
    </label>  
    <button type="submit">Login</button>  
if (View.LoginFailed)  
   {  
    <div class="error">Wrong Password!</div>  
   }  
}  
```

Does of you with a sharp eye have already seen what I failed in.
    
```
<input type="hidden" name="ReturnUrl" value="@View.ReturnURl" />  
```

Should have been:

```
<input type="hidden" name="ReturnUrl" value="@View.ReturnUrl" />  
```


And yes, a unit test would have caught that.

`</rant>`
