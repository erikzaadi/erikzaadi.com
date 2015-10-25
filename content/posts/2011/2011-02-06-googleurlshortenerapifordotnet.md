---
date: '2011-02-06'
layout: post
slug: googleurlshortenerapifordotnet
status: publish
title: Google Url Shortener Api for .net
wordpress_id: '9'
comments: true
categories:
- CSharp
- opensource
---

I read a short and concise [post](http://davidwalsh.name/google-url) by [David Walsh](http://davidwalsh.name), demonstrating a simple php class for using the new Google Url shortener Api.

I played around with the code a bit in C#, and voila! A .net version (with some additions).

```
var googleShorter = new GoogleUrlApi("PUT_YOUR_LONG_KEY_HERE");  
  
var urlToPlayWith = "http://www.google.com";  
  
var shortUrl = googleShorter.Shorten(urlToPlayWith);  
  
var longUrl = googleShorter.Expand(shortUrl);  
  
var longUrlDetails = googleShorter.ExpandFull(shortUrl);  
  
var analytics = googleShorter.GetAnalytics(shortUrl);  
```

Besides just creating short urls and expanding them, you can also get Analytics information about the shortened urls.

The analytics includes summaries of clicks, with drilldown details per month, week day etc.

Grab the source at : [https://github.com/erikzaadi/GoogleUrlApi.net](https://github.com/erikzaadi/GoogleUrlApi.net)

It's open sourced under the Apache 2.0 license, so knock yourself out!

Enjoy!

Erik
