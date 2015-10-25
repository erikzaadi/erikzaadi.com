---
layout: post
title: "handle proxy 404 in nginx"
date: 2014-06-23
comments: true
categories: 
 - nginx
---

In our SPA era, when you get a 40x or 500x (Oy vei) error from your proxied backend, you typically want to display a static part of your SPA.

To do this, we can usual a small but usefull nugget from nginx: 

*HERE BE DRAGONS*

```
proxy_intercept_errors on;
```

This ensures that if the proxied backend returns an error status, nginx will be the one showing the error page.

We need to tell nginx to handle the 404:

```
server { 
  #...
  error_page 404 = @404;
  #...
}
```

Notice the use of the `@404` location alias, it allows us to redirect as we wish:

```
  location @404 {                                                                                                                                        
    return 302 /app-path-to-404;
  }                                                                                                                                         
```

Here's a full sample:

```
upstream your-api-cluster {
  server localhost:1337 max_fails=3  fail_timeout=10s ;
  keepalive 16;
}


server {
  root /path/to/your/static/site/;

  location @404 {                                                                                                                                        
    return 302 /app-path-to-404;
  }                                                                                                                                         

  error_page 404 = @404;

  location / {
    autoindex off;
    expires 1h;

    #...
  }

  location /api{
    proxy_intercept_errors on;
    proxy_pass http://your-api-cluster/api;
    proxy_redirect   off;
    proxy_set_header Host            $host;
    proxy_set_header X-Real-IP       $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    
    #...
  }
}
```

Enjoy!
