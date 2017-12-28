---
date: '2011-03-02'
slug: installscripttorunaspdotnetmvc3withrazoronnginxataopensuseserver
status: publish
title: Install script to run asp.net mvc 3 with Razor on nginx at a OpenSuse server
wordpress_id: '7'
comments: true
categories:
- aspnetmvc
- CSharp
- mono
---

Well, the title kind of says it all ;)

For the git lovers out there clone [https://github.com/erikzaadi/MonoRazorScripts.git](https://github.com/erikzaadi/MonoRazorScripts.git), or simply download the zip from [https://github.com/erikzaadi/MonoRazorScripts/zipball/master](https://github.com/erikzaadi/MonoRazorScripts/zipball/master) and unzip it.

Then run :

`sudo sh ./install.sh`

And voila, a couple of minutes later, you should be able to access your server via http to get some GUID-alicios Razor driven content!

![](/images//Image_thumb1.png)

To deploy your application:
  1. Delete the directory _"/srv/www/monodocs/default"_
  2. Copy your application to _"/srv/www/monodocs/"_ and rename your folder name to _"default"_
  3. Copy the file _"Default.aspx"_ into the new _"default"_ folder
  4. Copy the dll files in the folder _"/srv/www/monodocs/libs"_ into the bin folder of your application
  5. If you have the file _"Microsoft.Web.Infrastructure.dll"_ in your bin folder, delete it

The source is at : [https://github.com/erikzaadi/MonoRazorScripts](https://github.com/erikzaadi/MonoRazorScripts)

If you need the Amazon EC2 AMI id's for Opensuse, have a look here : [http://susegallery.com/a/n0rKOx/opensuse-113-ami](http://susegallery.com/a/n0rKOx/opensuse-113-ami)

Enjoy!
