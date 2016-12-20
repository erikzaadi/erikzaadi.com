---
layout: post
title: "Fixing Thunderbird crashes on load and Mutt fails with fetched mail"
date: 2012-07-08
comments: true
categories: [misc, mutt, fetchmail]
---

If you use your unix mail spool/box with any type of fetchmail (ahem fetchnotes), on rare occasions, the mail box might be corrupted, typically missing a single starting character.

Thunderbird will fail miserably without any explanations, and Mutt will complain that the mailbox is invalid.

Open the mailbox (`/var/mail/$USER` usually) in your favorite editor (`vim` of course), and have a look at the beginning of the file:

It should start like this:
```bash
From username Sun Jul  8 2012
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
From: "" <some@mail.com>
To: "My Name" <my@mail.com>
Subject: =?UTF-8?Q?Some Title?=
Date: Sun, 8 Jul 2012 (IDT)
Message-ID: <462381293.437.1341746912677.mail.user@host>
MIME-Version: 1.0
... (Rest of mail)
```

If your mail file is corrupted, you'll see that it simply lacks the first `F` character:
```bash
rom username Sun Jul  8 2012
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
From: "" <some@mail.com>
To: "My Name" <my@mail.com>
Subject: =?UTF-8?Q?Some Title?=
Date: Sun, 8 Jul 2012 (IDT)
Message-ID: <462381293.437.1341746912677.mail.user@host>
MIME-Version: 1.0
... (Rest of mail)
```

Add that `F` character and Thunderbird won't fail, and mutt will load.

A silly problem with an even more dumber solution.
