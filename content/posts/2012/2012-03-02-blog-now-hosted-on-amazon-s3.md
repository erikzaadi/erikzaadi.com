---
title: "Blog now hosted on Amazon S3"
date: 2012-03-02
comments: true
categories: [amazon, s3, octopress]
---

After migrating my blog from wp to octopress (see [previous post](/2012/02/28/word-to-octo-press/)), I started thinking that it might be a waste using a (shared) hosting account just to serve static files. 
Since I use [Amazon Web Services](http://aws.amazon.com) a lot, I thought I might give [Amazon S3](http://aws.amazon.com/s3) a shot.

There's a zillion posts out there of how to make a static site in S3, including for octopress sites, so I won't bother you with repeating the steps here (see the links in the end of the post).

There are two pitfalls worth repeating though:

### DNS

You can't point your bare domain to your S3 bucket, as it requires a CNAME record and not a A record.

This is mainly due to Amazons' dynamic IPs (which is a good thing).

The only way to point to the static S3 site is with a subdomain, typically with 'www'.

You might have a domain registrar which can mask the request to the bare domain to the 'www' subdomain, however I was not so lucky :(

I did however find a free service called [wwwizer](http://wwwizer.com), which redirects your bare domain requests to the 'www' subdomain.

It's a bit akward that this occurs on the http level and not at the DNS, but hey, it's free and it works.

### Syncing your site to S3

There are tons of ways you can sync the generated static site to S3.

1.  There are two uploaders (regular and java app) at the [aws console](http://aws.amazon.com/console/s3)
2.  Several browser extensions and desktop apps
3.  A gem called [jekyll-s3](https://github.com/versapay/jekyll-s3) which uploads the generated `\_site` folder.

    This works great, but is hardcoded to use the `\_site` folder, and you need to tweak octopress a bit to change it from `public`.

    The annoying thing I saw was that it's uploading assets that haven't changed.

    I forked the project and started hacking away on a option to pass the folder name to upload to s3.

4.  A cli based client called [s3cmd](http://s3tools.org/s3cmd) available via homebrew, apt etc.

    This is an awesome client, which you can use to sync the generated site, uploading only the changed content.

    I actually forked octopress and submitted a [pull request](https://github.com/imathis/octopress/pull/460) with a deployment step using s3cmd, it was actually only after I submitted the pull request that I saw several other identical pull requests....


#### Links with explanations of how to host a static site on s3
<http://thechrisoshow.com/2011/06/05/how-to-host-a-static-website-on-s3>

<http://aws.typepad.com/aws/2011/02/host-your-static-website-on-amazon-s3.html>

<http://www.ianwootten.co.uk/2011/09/09/hosting-an-octopress-blog-on-amazon-s3>
