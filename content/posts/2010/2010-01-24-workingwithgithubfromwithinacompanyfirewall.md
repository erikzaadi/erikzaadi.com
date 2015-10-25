---
date: '2010-01-24'
layout: post
slug: workingwithgithubfromwithinacompanyfirewall
status: publish
title: Working with Github from within a company firewall
wordpress_id: '27'
comments: true
categories:
- Github
---


Most companies with somewhat restricted firewall rules typically enables only web traffic using port 80 or 443 (for SSL).
            

Git is communicating with Github using port 22 (or the default 9418), which in my own case was blocked after a while.
            

To keep _"gittin"_ from work there are some options.
            
  1. Work with pure http access (port 80) `git clone http://github.com/username/repository.git`
     This will only give you read only access and is rather slow
                
  1. Use githubs public server `ssh.github.com`, which works via port 443 `git clone ssh://git@ssh.github.com:443/username/repository.git`


I use the second one, and it works great, haven't seen any speed tolls so far.
            

Reference : [http://returnbooleantrue.blogspot.com/2009/06/using-github-through-draconian-proxies.html](http://returnbooleantrue.blogspot.com/2009/06/using-github-through-draconian-proxies.html)
            
Cheers,
        
Erik
