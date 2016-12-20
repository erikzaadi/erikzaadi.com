---
layout: post
title: "Auto Auto Reloading iPython modules"
date: 2013-03-14
comments: true
categories: [python]
---

You all use ipython, it’s an awesome tool.

However, it’s kind of annoying to exit and re-enter ipython when you change your python files.

There’s an extension built into ipython called autoreload which can be loaded by entering:

```python
%load_ext autoreload
%autoreload 2
```

Now whenever you edit your file, your objects will be updated in ipython without the need to close and reopen ipython.

But entering those lines each time you pop open ipython isn’t fun either.

Enter ipython profiles!

```bash
ipython profile create
cat << EOF >> ~/.config/ipython/profile_default/ipython_config.py

#w00t : taken from erikzaadi.com!
 
c.InteractiveShellApp.exec_lines = []
c.InteractiveShellApp.exec_lines.append('%load_ext autoreload')
c.InteractiveShellApp.exec_lines.append('%autoreload 2') 
 
EOF
```

And BOOM, you’re auto auto reloading python modules **L I K E A B O S S !!1**
