---
date: 2015-10-27T09:13:29+02:00
description: "Yo dawg, I heard you like to process logs with Logstash..."
title: Hush hush now Logstash
categories: [logstash, ops]
---

### What do you do when your logging infrastructure logs to much?

![](/images/yo_dawg_logstash.jpg)

Logstash is almost the facto log infratructure tool nowadays.

Although scaling it up is a bit *interesting* to say the least, Logstash works.

As any tool, it has some rough edges you might encounter.

We had a problem that Logstash's own logs were being filled up in blazing rates.

The messages were mostly non critical warnings of retries etc.

Initially, we tried to fix it with good old `logrotate`, but at peaks, the log would fill up faster than the `logrotate` samling rate.

We even got so far as adding a `cron` job that ran every 5 minutes that truncated the log, but we had peaks that filled the disk even faster than that.

After poking around I found a **MAGIC** command line parameter:

```
--quiet
```

This will cause Logstash to only output errors and supress warnings.

We altered the `upstart` job to pass the *STFU* parameter to the Logstash agent, and BOOM, no more pagerduties of filled disk space.
