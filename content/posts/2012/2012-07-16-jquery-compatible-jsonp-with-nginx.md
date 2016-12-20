---
layout: post
title: "jQuery Compatible JSONP with Nginx"
date: 2012-07-16
comments: true
categories: [nginx, jquery, web, development]
---

I got inspired by [this awesome article](http://www.gabrielweinberg.com/blog/2011/07/nginx-json-hacks.html) by Gabriel Weinberg to hack a bit on [nginx](http://nginx.org).

It's a great article which I highly recommend to read.

The part that specifically interested me was turning JSON into JSONP compatible calls, usable both for proxying remote / local apis that doesn't supply JSONP functionality and for simple to padd local static JSON files.

What bothered me though was the fact that the name of the method to pad into the JSON response was hard coded.

Here's Gabriels code snippet:
```nginx
#Gabriel Weinbegs Code Snippet http://www.gabrielweinberg.com/blog/2011/07/nginx-json-hacks.html
location ^~ /ext_api3/ {
    echo_before_body 'parseResponse(;
    proxy_pass http://api.external.com/;
    echo_after_body ');';
}
```
When you use jQuery to do an ajax request, you add `?callback=?` to your url, which will be replaced by a random function name, E.g: `callback=jQuery123123`.
To achieve the same with nginx, I modified the snippet:

```nginx
#Modified to handle callback variable
location /json/ { #can be any location of course
    if ( $arg_callback ) {
        echo_before_body '$arg_callback(';
        echo_after_body ');';
    }
    #proxy or remote here
    try_files $uri $uri/ /index.html;
}
```

Now if we take a simple JSON file:
```json
{
    "aa" : "bb",
    "cc" : 123
}
```

And call nginx to fetch it via the location we configured in the snippet above, with the url `http://server.com/json/sample.json?callback=Ahoy` we'd get:
```javascript
Ahoy({
    "aa" : "bb",
    "cc" : 123
});
```

Enjoy
