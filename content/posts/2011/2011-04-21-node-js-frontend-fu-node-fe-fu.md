---
date: '2011-04-21'
layout: post
slug: node-js-frontend-fu-node-fe-fu
status: publish
title: Node.js Frontend Fu (node-fe-fu)
wordpress_id: '260'
comments: true
categories:
- node.js
---

As you might have noticed from my [previous post](http://erikzaadi.com/2011/04/20/node-js-much-more-then-a-webserver/), My geekadellic franzy about [node.js](http://nodejs.org) is reaching new peaks..

I've created a small node.js module to be used not as a web server, but more as an aid for developing frontend applications regardless of the backend technology used.

What the module does is:

1. Searches for [.less](http://lesscss.org) files, parses them, and saves two copies of the file:
    E.g.
        `css/main.less`
    Will be transformed into
        `css/main.css`  - parsed less to css
        `css/main.min.css`  - parsed less to css and minified
2. Searches for .js files, minifies them:
    E.g.
        `js/main.js`
    Will be minified and saved to 
        `js/main.min.js`


You can choose to search directories recursively, and if you wish to watch the files for changes, triggering a parsing/minification upon each save.

Each change triggers a growl notification, so you'll be able to catch errors earlier:

![Info growl](/images/fe-fu-info.png)

![Error Growl](/images/fe-fu-error.png)


**Installing:**

Install node.js and npm (see [https://github.com/joyent/node/wiki/Installation](https://github.com/joyent/node/wiki/Installation) )  _Be sure to have the node library in your path!_ 

Open up your terminal :
    
```
npm install fe-fu
```
    

If everything works, you should now be able to do :
    
```
fe-fu --jsDir ./js --lessDir ./css
```
    

That's it!

**Roadmap:**

Support combining files

Add images for Growl notifications (Info / Error) **Done!**

Add more optimizations (pngcrushing, html minification, sprites etc)

**Node modules used:**

  * [uglify-js](https://github.com/mishoo/UglifyJS)
  * [clean-css](https://github.com/GoalSmashers/clean-css)
  * [optimist](https://github.com/substack/node-optimist)
  * [libnotify](https://github.com/mytrile/node-libnotify)
  * [growl](https://github.com/visionmedia/node-growl)
  * [less](https://github.com/cloudhead/less.js)

The source is up at [github](https://github.com/erikzaadi/node-fe-fu)
