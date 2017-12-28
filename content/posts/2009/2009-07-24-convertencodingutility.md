---
date: '2009-07-24'
slug: convertencodingutility
status: publish
title: Convert Encoding Utility
wordpress_id: '45'
comments: true
categories:
- CSharp
- Utilities
---

## Prelude (skip):

I had another one of those ["utilicous"](http://erikzaadi.com/blog/2009/07/21/JoyOfWritingUtilities.xhtml) moments again.

I ran into a familiar problem that I've met before:

I had a site written in ANSI encoding (default behavior by
Visual Studio BTW) , with some localized Hebrew content. The
default settings if the web site in IIS were indeed ANSI for
reading the files, and UTF-8 for displaying the files.

 
Peaches, everything was working fine..
 

Then I had to move the site to a different server..

Suddenly my site looked like a wingdings party.

The new server had different regional settings, and UTF-8 as
the default for reading files.

I soon realized I had to go over the entire site, saving all
files to UTF-8

(Yes, a better practice would have been to do so
from the beginning, and override the default file encoding in the
web.config).

Suddenly the [_"utilicous"_]("http://erikzaadi.blogspot.com/2009/07/joy-of-writing-utilities.html) feeling was all over me
again, Time for a utility!

## Thus the Convert Encoding Utility Was Born…

Ok, so I got the idea for what was needed, a small WinForm
application that'll choose a root folder, and perhaps even file
extensions to modify.

After finishing the [WinForm](http://www.hotlinkfiles.com/files/2682836_nrsxk/winform.jpg), I got that _"hmm this could be
useful for others"_ feeling.

After some refactoring, and I separated the solution to 3
projects:


## Base library


#### Exposes methods that alter the file encoding either of a single
file, or of a folder (with the possibility to filter by file
extensions)

[Wiki](http://wiki.github.com/erikzaadi/ConvertToEncodingTool/base-library-encodingconverter)
[Download (Entire solution)](http://github.com/erikzaadi/ConvertToEncodingTool/zipball/0.5)
    

## Console application

#### Uses the library above. Can get command line arguments such as
single file to modify or a root directory (with the possibility to filter by file extensions)

[Wiki](http://wiki.github.com/erikzaadi/ConvertToEncodingTool/console-converter)
[Download](http://cloud.github.com/downloads/erikzaadi/ConvertToEncodingTool/Console_0.5.zip)

## WinForm application

#### Same as the console, but with [UI](http://www.hotlinkfiles.com/files/2682836_nrsxk/winform.jpg)

[Wiki](http://wiki.github.com/erikzaadi/ConvertToEncodingTool/windows-converter-utility)
[Download](http://cloud.github.com/downloads/erikzaadi/ConvertToEncodingTool/Winform_0.5.zip)
   
If you have any problems with the utilities, code or the
documentation, please report it at [Issues section](http://github.com/erikzaadi/ConvertToEncodingTool/issues)

Enjoy,

Erik
