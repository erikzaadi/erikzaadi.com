---
layout: post
title: "Fast remote editing with Vim"
date: 2013-03-07
comments: true
categories: [vim, scp, linux]
---

#### *UPDATED:* bash script now even more cool!

There's a feature in vim of editing files over scp, built in since vim 7.1 (originially the now baked in [netrw](http://www.vim.org/scripts/script.php?script_id=1075) plugin).

This feature uses scp to copy a local version of the remote file over scp, edit it with vim, and with each save connect via scp and save it to the remote location.

This allows you to edit remote files with your own tailored vim instance (plugin galore!).

The problem is the connection is not reused, and it's really slow when vim (scp) connects for each write.

To solve that, save this script and `chmod a+x` it..

```bash
#!/bin/bash
echo "vim-scp FTW"
if [ $# -ne 2 ]; then
    echo "usage : `basename $0` user@host /path"
    exit 1
fi
COMMAND="ssh $1 -f -N -o ControlMaster=auto -o ControlPath=/tmp/%r@%h:%p"
echo "opening ssh tunnel.."
$COMMAND || exit $? 
echo "ssh tunnel active, opening vim.."
vim scp://$1$2
echo "closing ssh tunnel.."
ps -ef | grep "$COMMAND" | grep -v grep | awk '{print $2}' | xargs kill -9
echo "Great Success!"
```

This script opens a ssh connection without running any command in the background using `ssh -f -N`.

Then the script calls vim with the wanted path to edit, and finally kills the background ssh process when you're done editing.

Run 

```bash
vim-scp myuser@some.host.com /dir/path/or_file
```

And you're editing remote files with vim *blazing fast*..

Enjoy!
