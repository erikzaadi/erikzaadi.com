---
date: '2010-03-05'
slug: compressjavascriptwithgoogleclosurecompilerinvisualstudiowithjquerysupport
status: publish
title: Compress Javascript with Google Closure Compiler in Visual Studio (with jQuery support)
comments: true
wordpress_id: '24'
categories:
- GoogleClosureCompiler
- jQuery
- JQueryPlugins
- VisualStudio
---

[Google Closure Compiler](http://code.google.com/closure/compiler/docs/overview.html) is an amazing tool.
Besides having the best compression rate (and being the official choice of [jQuery](http://jquery.com)), it really alters the way you write javascript.

When using the [Advanced Optimization](http://code.google.com/closure/compiler/docs/api-tutorial3.html) option, it forces you to write more concise code, exposing only what really matters to the global namespace.

There's a lot more the be said in that matter, but that's material for a future post about how [Google Closure Compiler](http://code.google.com/closure/compiler/docs/overview.html) changed the way I write [jQuery](http://jquery.com) plugins.

For now, we'll only set up a quick way of invoking the [Google Closure Compiler](http://code.google.com/closure/compiler/docs/overview.html) from within Visual Studio.

##### Steps:

  1. Download the [compiler.jar](http://closure-compiler.googlecode.com/files/compiler-latest.zip) package and unzip it.

  2. Be sure to have at least the java run time installed (the java development kit will of course also do fine), both available [here](http://java.sun.com/javase/downloads/index.jsp).

  3. In Visual Studio, click "Tools" -> "External Tools", then click "Add"
  
  4. Enter the title of your choice, and at the "Command", click the browse ("…") button and locate java.exe (should be something like this : `C:\Program Files\Java\jdk1.6.0_18\bin\java.exe`)
  
  5. At the "Arguments" enter the following:  `-jar X:\Path\To\YourDownloadedAndUnzipped\compiler.jar --js $(ItemPath) --js_output_file $(ItemDir)$(ItemFileName).min.js --compilation_level ADVANCED_OPTIMIZATIONS --summary_detail_level 3`

  6. Check the "Use Output window" checkbox
  
  7. Click "Ok" to save your changes

  8. Open a javascript file and and click "Tools" -> "The Title You Gave To Google Closure Compiler"


You should see the output folder popup with the following
message `0 error(s), 0 warning(s)`

That's if you don't have any errors in your javascript of course :)

##### Caveats:

The `ADVANCED_OPTIMIZATIONS` really changes a lot in your javascript, and it's worth reading through google's [documentation](http://code.google.com/closure/compiler/docs/api-tutorial3.html) in the matter if your javascript
is broken after the compression.

##### Making it work with jQuery:

Since the `ADVANCED_OPTIMIZATIONS` will try to shorten all variables and function names, it breaks any jQuery plugin when compressed.

To overcome this problem, we'll tell the [Google Closure Compiler](http://code.google.com/closure/compiler/docs/overview.html) to use jQuery as an external reference, ensuring that the name of any jQuery function will be preserved.


    1. Download the latest uncompressed version of [jQuery](http://jquery.com) ([1.4.2](http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.js) at the time this post was written) to the folder you unzipped "compiler.jar" and call the file `jquery.js`
  
    2. Create a file called `withjQuery.bat` in the same folder and add the following content:   
 
```batch
@ECHO OFF  
  
SET InputFile=%1  
SET OutputFile=%2  
  
@ECHO *********************************************  
@ECHO Google Closure Compiler with jQuery Support   
@ECHO Compiling : '%InputFile%'  
@ECHO *********************************************  
  
CALL "c:\Program Files\Java\jdk1.6.0_18\bin\java.exe" -jar X:\Path\To\YourDownloadedAndUnzipped\compiler.jar --js %InputFile% --js_output_file %OutputFile% --compilation_level ADVANCED_OPTIMIZATIONS --summary_detail_level 3 --warning_level QUIET --externs X:\Path\To\YourDownloadedAndUnzipped\jquery.js  
  
@ECHO *********************************************  
@ECHO Build Complete  
@ECHO *********************************************  
```
  
  3. Add another External Tool as before, this time, choose the .bat
file you created as "Command"

  
  4. As "Arguments" enter :  `$(ItemPath) $(ItemDir)$(ItemFileName).min.js`

  
  5. Be sure to check the "Use Output window" checkbox as before

##### Small note:

You might want to integrate the [Google Closure Compiler](http://code.google.com/closure/compiler/docs/overview.html) as a build step instead of an External Tool as explained here, if so I hope the small tips above will help you do so!  

Give it a try!

Erik
