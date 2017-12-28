---
date: '2011-10-02'
slug: jenkins-on-nginx-fixing-artifacts-downloading-problem
status: publish
title: Jenkins on Nginx - Fixing artifacts downloading problem
wordpress_id: '357'
comments: true
categories:
- Jenkins
tags:
- ci
- jenkins
- nginx
---

For those of you using Nginx to proxy Jenkins, be sure to copy the updated nginx server config from the wiki page [https://wiki.jenkins-ci.org/display/JENKINS/Running+Hudson+behind+Nginx](https://wiki.jenkins-ci.org/display/JENKINS/Running+Hudson+behind+Nginx).

I added some proxy buffer specific parameters that fixes artifact downloading..
