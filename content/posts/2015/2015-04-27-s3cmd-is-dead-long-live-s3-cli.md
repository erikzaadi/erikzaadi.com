---
layout: post
title: "s3cmd is dead, long live s3-cli"
date: 2015-04-27
comments: true
categories: [s3, amazon, node, nodejs, octopress, s3cmd, s3-cli]
---

For those of you that still use Octopress like me, one of the annoying things is deploying to Amazon S3.

I was using `s3cmd` which is indeed an awesome utility to sync the rendered blog to S3, however it's slow, it'll take about 5 minutes to deploy my blog, which is not a huge blog.

While implementing a quick hack that uploads images to Amazon S3, I stumbeled upon a certain Mr Awesome called [Andrew Kelley - @andrewrk](https://github.com/andrewrk), who's [node s3 client](https://github.com/andrewrk/node-s3-client) I used.

In the README for the node-s3-client there was a link to [s3-cli](https://github.com/andrewrk/node-s3-cli).

This is a inplace replace to `s3cmd`, written in node (yaay!), which works flawlessly with the existing s3cmd configuration, which (amongs other awsome stuff), uploads to S3 in parallel, saving LOADS of time.

I did a quick change to the Octopress Rakefile

```
diff --git a/Rakefile b/Rakefile
index fccdd5e..47f3e09 100755
--- a/Rakefile
+++ b/Rakefile
@@ -403,10 +403,10 @@ task :list do
   puts "(type rake -T for more detail)\n\n"
 end
 
-desc "Deploy with s3cmd"
+desc "Deploy with s3-cli"
 task :s3 do
     puts "S3 FTW"
     cd "#{public_dir}" do
-        system "s3cmd sync --delete-removed . s3://yourbucket.com/"
+        system "s3-cli sync --delete-removed . s3://yourbucket.com/"
     end
 end
```

And _Voila_! Deploy time reduced from 5 minutes to 17 seconds (UBER W000TZ!!1)


Stay classy San Diego.
