---
date: '2011-09-09'
layout: post
slug: connecting-jenkins-to-self-signed-certificated-servers
status: publish
title: Connecting Jenkins to self signed certificated servers
wordpress_id: '351'
comments: true
categories:
- Java
- Jenkins
tags:
- java
- jenkins
- ssl
---

![](/images/unlocked-icon.png)

I've recently needed to connect our Jenkins CI server to several internal servers such as Jira and IRC (Fun post coming soon on Jenkins@IRC..).

The problem with these servers are that their SSL certificates are selfsigned.
This causes Jenkins to fail when connecting to the servers with the following error (Which you can see in the Jenkins log):

```    
javax.net.ssl.SSLHandshakeException: sun.security.validator.ValidatorException:
PKIX path building failed:
sun.security.provider.certpath.SunCertPathBuilderException:
unable to find valid certification path to requested target
```

To solve the problem, instead of going through Java keysigning hell, download [JavaSSL.zip](http://demos.erikzaadi.com/jenkins/JavaSSL.zip), extract the files and open a command prompt or shell to the extracted folder.

Then run :

```
java InstallCert yourServerOrIP
```

By default, it'll try port `443`, however if you need a custom port, say `8888` run:

``` 
java InstallCert yourServerOrIP:8888
```

When prompted, accept the certificate.
This will create a file called 'jssecacerts' in the same directory.
Notice that the command will list a alias for your server, we'll use that later.

Now copy / symlink the `jssecacerts` into `$JAVA_HOME/jre/lib/security`.
If you can't find your `JAVA_HOME` dir, try `ls -l /usr/bin/java` on \*nix, or the installed java directory in your program files on Windows.
Furthermore, copy / symlink the same file to your home directory and rename to `.keystore`

To test that it works, run:
    
```
keytool -list
```

When prompted for a password, enter `changeit`

You should now be able to see the certificate you imported.
To narrow down the keytool search, you can run

```
keytool -list -alias yourServerAlias
```

where alias is the name you should have seen in the end of the `InstallCert` command.

To test that the connection works, we'll run:

```    
java SSLPoke yourServerOrIP
```

or if you need a custom port, for example `8888`:

```    
java SSLPoke yourServerOrIP 8888
```

Hopefully you'll get a connection succeded, if so, restart Jenkins, and you should be able to connect to the self signed certificated server.

References : [InstallCert](http://blogs.oracle.com/gc/entry/unable_to_find_valid_certification ) and [SSLPoke](http://confluence.atlassian.com/display/JIRA/Connecting+to+SSL+services)
