---

date: 2017-02-07T08:31:59+02:00
description: "Because Jenkins also needs to be automated..."
title: "Why you should be excited about the groovyness of Jenkins"
categories: ['Jenkins', 'CI', 'groovy']
tags: ['Jenkins', 'CI', 'groovy']

---

### Prelude

I've been using [Jenkins](https://jenkins-ci.org) since it was called Hudson.

With the rise of SaaS services like [Travis](https://travis-ci.com), Jenkins started to feel a tad bit cumbersome.

Suddenly it was a burden to manage it your self, from provisioning servers to make sure everything worked.

Sure, Travis had it's own caveats, like lacking versions of needed infrastructure versions, long waiting time for builds to be scheduled and slow builds.

But hey, it was the new cool thing.

Add to the fact that Travis was free for OpenSource projects, which made the hype realistic and approachable.

Not only that, Travis gave you immutable infrastructure, something that I always suffered the lack of in Jenkins.

E.g. Travis builds would fail not because of low disk space, dirty environments etc.

As for Jenkins, all jobs would typically be defined in Jenkins as bash build steps, far away from your codebase, and only in good scenarios would even be backed up.

### Time for a change

Suddenly, [Kohsuke](http://kohsuke.org/) stroke back, with the introduction of [Pipelines](https://jenkins.io/doc/book/pipeline/getting-started/) and the amazing [Jenkinsfile](https://jenkins.io/doc/book/pipeline/jenkinsfile/), Jenkins became relevant again.

This move was dramatic, because not only did it get you to do your builds in [Groovy](http://www.groovy-lang.org/) as oppose to bash, you could suddenly reuse Job logic, and manage everything in code.

_Yes Yes, I know this was available before, but Jenkins 2.0 really emphasized it enough to become mainstream_

### The Groovy

Groovy in general has it setbacks, Especially within Jenkins, for example [closures might not work](https://issues.jenkins-ci.org/browse/JENKINS-26481).

Having said that, Groovy is a hell of a lot better than bash.

It allows you reuse of code for build logic, dynamic and controlled flows, paralleling and more.

### Shared Groovy Libraries

[Groovy Shared Libraries](https://jenkins.io/doc/book/pipeline/shared-libraries/) took it even further, you can now create a shared library instead of using the same groovy script file included over and over.

Not only that, it allows you to create super simple DSLs to use instead of actually writing groovy code.

### Ok Ok, nuff said, demo time.

At BigPanda we build nodejs, scala, python, golang, typescript and frontend projects.

Using the new Jenkinsfile feature combined with the Groovy Shared Library, we end up with the following `Jenkinsfile` in each project's repository:


```java
nodeJsBuild {
    neededInfraStructure = ['mongo', 'rabbitmq', 'redis']
    nodeVersion = 'v6.2.0'
}
```

```java
scalaBuild {
    neededInfraStructure = ['mongo', 'rabbitmq', 'kafka', 'elasticsearch']
}
```

```java
golangBuild {
    golangVersion = "1.7.5"
}
```

And so on.

Each build might have it's own quirks, but they all use shared components for anything in common, from cloning to gathering unit tests.

E.g

```java
package io.bigpanda

def static UpdateBuildDescription(script, buildParams) {
    def description = "#${script.currentBuild.number} - ${buildParams.Git.Branch} - ${buildParams.Git.Author.Name}"
    Debug(script, "Updating build description to ${description}")
    script.currentBuild.displayName = description
}

def static Clone(script) {
    Debug(script, "Cloning ${script.scm.branches} from ${script.scm.userRemoteConfigs}")
    script.checkout([$class: 'GitSCM', branches: script.scm.branches, doGenerateSubmoduleConfigurations: false, extensions: script.scm.extensions + [[$class: 'PruneStaleBranch']], userRemoteConfigs: script.scm.userRemoteConfigs])
}

def static GatherXUnitTestResult(script, resultXmlPath, forceTestResults) {
    Debug(script, "Gathering test results from ${resultXmlPath}")
    script.junit allowEmptyResults: !forceTestResults, testResults: resultXmlPath
}
```

Updating your build system is as easy as releasing to your shared groovy library's git repository.

Jenkins will even note for each job that runs what sha of your groovy library is running.

### What does all this mean?

That nowadays, all you need is [Github Organization](https://wiki.jenkins-ci.org/display/JENKINS/GitHub+Organization+Folder+Plugin) `=>` Jenkinsfile with DSL `=>` Groovy Shared library and you're set!
