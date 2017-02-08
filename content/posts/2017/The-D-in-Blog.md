---

date: 2017-02-08T08:13:13+02:00
description: "Continuous deployment for a static blog engine"
title: "The D in Blog"
categories: [CI, CD, blog, S3]
---

## Humans make mistakes.

My [last blog post](/2017/02/07/why-you-should-be-exited-about-the-groovyness-of-jenkins/) was written on a train, just like this blog post.

I proof read the post about 4 times to check spelling, grammar and too bad jokes.

All seemed legit, so I published the post.

Little did I know that all the time I spent on checking the content, I forgot to check the actual title of the blog.

![Panda Facepalm](/images/panda-facepalm.gif)

I noticed the typo only when the amazong [abyx](http://www.codelord.net) mentioned it in a Facebook comment.

By then I was driving to a Kung Fu practice far away from my Mac.

Luckily for me, I've invested in automating ALL THE THINGZ at my blog, so all I had to do to fix the problem was to open Github from my phone, edit the blog post and commit, and voila, the horrible mistake was fixed.

_Yes Yes, I only fixed the title, the Url still has the typo in it, didn't want to mess with the SEO gods.._

Anyhuze, I got some questions about how the duck that would work, and decided to write this post to explain DA FLOWZ.

## WAT

I'm using [Hugo](https://gohugo.io), a static content generator written in Golang (FTW).

The source of the blog is up at [Github](https://github.com/erikzaadi/erikzaadi.com).

The actual blog site is hosted at Amazon S3.

Upon pushing to the master branch, [Travis](https://travis-ci.org) builds the site using Hugo, then deploys to Amazon S3. 

After Travis finishes successfully I get a push notification to my phone using [NMA](http://www.notifymyandroid.com/)

![NMA Notification](/images/nma-blog.png)

## UBER WAT

If it interests you, have a look at [the source](https://github.com/erikzaadi/erikzaadi.com) to see how it works.

#### Bye Y'all

![Bye Spock](/images/bye-spock.gif)
