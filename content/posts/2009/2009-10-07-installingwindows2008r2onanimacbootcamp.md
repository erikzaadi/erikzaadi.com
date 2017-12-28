---
date: '2009-10-07'
slug: installingwindows2008r2onanimacbootcamp
status: publish
title: Installing Windows 2008 R2 on an iMac (Boot Camp)
wordpress_id: '38'
comments: true
categories:
- Install
- IT
- Mac
- Windows2008R2
---

Skip the prelude and show me the steps!

**Prelude:**

I have an amazing iMac at work. unfortunately, I spend most of my time on the Windows side of the Boot Camp, since I develop mostly Windows Based software. This requires quite some tweaks, since I can’t really develop and test properly if I’m not on a server based operating system.

 

I started with XP on the boot camp, but after a short (and annoying) period I understood that I had to install Windows 2003 server.

 

Alas, the only Windows operating systems officially supported by Apple are XP and Vista.

 

I managed to install the Windows Server 2003 with only a few driver hiccups (especially the network driver), and worked with that for a rather long period.

 

When Windows 2008 Server got to the second service pack I though it was stable enough to install.

 

The installation went more smoothly than the 2003, since Windows 2008 SP2 is based on Vista, thus most of the drivers included in the Boot Camp worked out of the box.

 

This worked for a while, but was annoying..

 

I’ve been working quite a while with Windows 7 at home, and after you get used to the new interface, the usability and the speed, going back to the 32bit Server 2008 at work is not so peachy.

 

Thankfully, Microsoft came out with Windows Server 2008 R2 (or should I saw Windows 7 Server).

 

Installing it was not as trivial as the previous versions, and that’s why I decide to write this LONG post :)

 

**Installation Steps:**

 

  
  1. Alter the ISO to work on Mac:        
Burning the original ISO downloaded from Microsoft wont work, you’ll see two CD’s (Windows and EFI), and booting from the windows will result in something like this:         
     

1.          
2.           
Select CD-ROM Boot Type: 

(The keyboard won't be responsive at all)         
Follow the instructions thoroughly from this great post : [http://jowie.com/blog/post/2008/02/24/Select-CD-ROM-Boot-Type-prompt-while-trying-to-boot-from-Vista-x64-DVD-burnt-from-iso-file.aspx](http://jowie.com/blog/post/2008/02/24/Select-CD-ROM-Boot-Type-prompt-while-trying-to-boot-from-Vista-x64-DVD-burnt-from-iso-file.aspx)         
**Be sure to notice the bold comments about Windows 7 (E.g. 8 sectors to load instead of 4).**
   
  2. Follow the instructions from [http://www.win2008r2workstation.com/](http://www.win2008r2workstation.com/) (especially the enable audio part) 
   
  3. Install Boot Camp (64 bit) from your Mac OS X CD 
   
  4. Upgrade Boot Camp to 2.1 (for 64 Bit Vista) - [http://www.apple.com/downloads/macosx/apple/application_updates/bootcampupdate21forwindowsvista64.html](http://www.apple.com/downloads/macosx/apple/application_updates/bootcampupdate21forwindowsvista64.html)
   
  5. The volume will be REALLY low, you need to install an updated driver for the RealTek Audio Card - [http://www.realtek.com.tw/downloads/downloadsCheck.aspx?Langid=1&PFid=24&Level=4&Conn=3&DownTypeID=3](http://www.realtek.com.tw/downloads/downloadsCheck.aspx?Langid=1&PFid=24&Level=4&Conn=3&DownTypeID=3)         
(Click accept to get to the download links) 
 

That’s it, you’re good to go!

Small note, 
The Windows 2008 R2 allows you to add your computer to the domain WITHOUT requiring a domain administrator’s password, as long as you are not using a name for the computer that has already been registered in the domain..

Cheers,

Erik
