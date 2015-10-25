---
date: '2009-05-16'
layout: post
slug: personalwebnostalgy
status: publish
title: Personal Web Nostalgy
wordpress_id: '48'
comments: true
categories:
- General
---

My fiance happened to googlestubmle upon this site:

[http://my.ort.org.il/rehovot/thing/](http://my.ort.org.il/rehovot/thing/)  

It's the first "official" web site I created back in high school, using FrontPage (!).

I find it rather ironic that the "It will be ready in a week." status is still there :)

Viewing the (hideous) source, you see plenty of unneeded tables, countless in-line styling and javascript..

Well, needless to say, IE4 was targeted as the default browser..

Here's a small snippet used for achieving a mouseover image swap:

```
<a 
    onmouseover="document['fpAnimswapImgFP1'].imgRolln=document['fpAnimswapImgFP1'].src; document['fpAnimswapImgFP1'].src=document['fpAnimswapImgFP1'].lowsrc;"
    onmouseout="document['fpAnimswapImgFP1'].src=document['fpAnimswapImgFP1'].imgRolln" 
    href="javascript:void(0)"
>
    <img border="0" src="images/amazulika.GIF"  id="fpAnimswapImgFP1" name="fpAnimswapImgFP1" dynamicanimation="fpAnimswapImgFP1" lowsrc="images/amazulika2.GIF" width="143" height="192">
</a>
```


  


That's even worse in-line junk than "modern" asp.net controls...

  


Anyhow, there's nothing amazing to learn from this post, except perhaps appreciate the tools at hand and the maturity of the browsers that we have nowadays.

  


Cheers,

  


Erik
