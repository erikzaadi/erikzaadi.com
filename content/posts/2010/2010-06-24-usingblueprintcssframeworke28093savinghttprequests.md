---
date: '2010-06-24'
slug: usingblueprintcssframework%e2%80%93savinghttprequests
status: publish
title: Using Blueprint CSS framework – saving http requests
wordpress_id: '16'
comments: true
categories:
- blueprintcss
---

I love the [blueprint](http://www.blueprintcss.org/) CSS framework, I've been using it for a while, and it's a very useful time saver.

The only thing that bugs me about it's usage is the nagging I keep getting from [YSlow](http://developer.yahoo.com/yslow/) and [PageSpeed](http://code.google.com/speed/page-speed/) about reducing the amount of http request in the page.

Since [blueprint](http://www.blueprintcss.org/) CSS uses at least two http requests (one for screen media, the other for print), and as much as four (IE version and show grid image), I thought of a small way to enhance this a bit.

### Meet the @media CSS selector

Using the `@media` CSS selector, we can differ between different medias for CSS rules.


**Example:**

```css
@media  screen, projection {  
    body { background: #CCC; }  
}  
@media print {  
    body { background: #FFF; }  
}  
```


That allows us to embed the print CSS into the main blueprint CSS saving one http request.

### Embedding images in the CSS as base64 encoded images

All modern browsers (Except IE below 8) can display images embedded in the CSS or Markup.

**Example:**

```css
.showgrid {
    background:url(data:image/png;base64,idsadsaVERYLONGBASE64String=)
}  
```

There's actually an online utility converting images to the base64 format, see [here](http://www.greywyvern.com/code/php/binary2base64).
This saves us another http request!

### As always, IE finds a way to ruin things..

The only extra http request left is the IE specific CSS.

You could solve this with some server side logic, however, this is not recommended, as won't help your caching.

Besides, whatever is solvable at client side, should be solved there!

### The final CSS :

[Download](http://gist.github.com/raw/451480/bce123cb8fa0d9f3e53b75a5e9e1861fe40acb7f/blueprint-with-print.css) | [Gist](http://gist.github.com/451480) (Do fork and improve!)

Enjoy
