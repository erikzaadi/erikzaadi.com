---
date: '2010-05-23'
slug: movingfromwebhost4lifetoarvixe
status: publish
title: Moving from Webhost4life to Arvixe
wordpress_id: '18'
comments: true
categories:
- arvixe
- Blog
- BlogMigration
- webhost4life
---

Webhost4life was my first hosting provider, I joined their service at November 2009.

Although their support was… not very technical, and REALLY slow on response time, I was able to solve most problems I had by myself.

In the middle of January, they announced that their moving to a new and _improved_ platform, and they even had this fancy "transition kiosk" that was suppose to find and resolve all potential migration problems automatically.

I looked at the new platforms control panel, and got the impression that this might really be an improvement.

After they migrated the account, it took about a month of nerve wrecking support calls, and my own manual attempts to fix their crappy ISAPI Rewrite templates to get my applications somewhat working.

Even then, all my .net apps were broken since they changed the way they worked with sub domains in a way that ruined all links generated by .net (E.G. using a simple _Url.Content("~/")_ would return an invalid path).

After a furious support log where I threatened to sue them, they finally moved me back the old platform.

Everything was back to normal.

Suddenly, at the beginning of May, I got an email from webhost4life saying that a migration must take place until May 17, since they old servers will no longer be active after that date.

Due to my history with the _infamous_ new and "improved" platform, I asked the following at a support call:

![](/images/Webhost4life3.png)

Webhost4life had integrated a new control panel (although in beta of course), so I had some slight hopes that this time it'd work.

After the migration, nothing worked.

Their incompetent support where not even able to get a simple _index.html_ working.

![](/images/Webhost4life23.png)

![](/images/Webhost4life33.png)

This time I didn't wait a month to get a partially working site.

After some nice tweeple suggested some hosting providers, I choose [Arvixe](http://arvixe.com), and so far they've been great.

[Arvixe](http://arvixe.com) .net support are far superior to webhost4life, they even have .net 4 support.

**_Small disclaimer_, I'm in no way affiliatedwith** [**Arvixe**](http://arvixe.com) **, I'm simply a satisfied customer** (so far).

They prices are cheaper, and you don't need to pay for the domain name, which saves you about ten bucks a year.

#### So what really happened with webhost4life?

They were a rather solid hosting provider with good .net support, but unfortunately, they were bought by Endurance International Group, who decided to make changes, radical changes there.

There are plenty "webhost4life's new platform ruined my site" , I think the best is : [http://fhemsher.blogspot.com/](http://fhemsher.blogspot.com/) 

Erik
