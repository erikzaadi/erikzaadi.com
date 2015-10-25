---
layout: post
title: "Cleaning up Jenkins jobs"
date: 2013-12-18
comments: true
categories: [jenkins, ci]
---

## Jenkins rules, but...

It's a Java XML consuming monster.

Once you get up to a large number of jobs (We are near 300), it gets a bit tough, especially when restarting.

So, every once in a while, I cleanup old unused jobs that are left over.


`delete_non_active_jobs.py`

```
import urllib2
import os
from shutil import rmtree

def get_active_jobs():
   request = urllib2.Request('http://localhost/api/python?tree=jobs[name]')
   opener = urllib2.build_opener() 
   json = opener.open(request)
   return [job['name'] for job in eval(json.read())['jobs']]

def get_jobs_dir():
   return os.walk('.').next()[1]


if __name__ == '__main__':
    jobs = get_active_jobs()
    jobs_in_dir = get_jobs_dir()
    jobs_to_delete = sorted([job for job in jobs_in_dir if job not in jobs]
    for job in jobs_to_delete:
        print "Deleting: '%s'" % job
        rmtree(os.path.abspath(os.path.join(os.curdir, job)))
```

Delete them allz'

```
cd ${JENKINS_HOME}
#note Jenkins must be up
python delete_non_active_jobs.py
service jenkins restart
```

![](/images/eval_is_not_evil.jpg)

![] (/images/eval___no.jpg)
