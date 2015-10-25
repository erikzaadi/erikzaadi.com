---
layout: post
title: "Two bots one Slack"
date: 2015-04-27
comments: true
categories: [hacks, slack, hubot]
---

We started evaluating [Slack](https://slack.com) at [BigPanda](http://bigpanda.io), and it is truly great.

The signup process was super simple, adding integrations is really fast, and all the apps, web and native feels fresh and fast.

Needless to say, one of the first things I did was to hook up on of our [Hubot](https://hubot.github.com) instances that controls our door (see [previous post](2015/03/05/raspberry-pi-powered-door/)).

With our previous not so hip chat, we did a quick hack, creating an Android Widget that calls our Hubot instance (called Bellboy), opening the door.
_Yes, a tad bit cumbersome, but this way we used the existing stack on our Raspberry Pi_.

Anyhuze, when jumping aboard to Slack, that was the only thing that was not smooth, it appears that Slack's Hubot adapter does not support Bot to Bot communication.

![Sad Robot](/images/sad_robot.png "Sad Robot")

That esentially means that all the things Hubot can `hear` are ignored if they're not originated from a real user.

A quick [Google search](http://stackoverflow.com/questions/26089699/how-to-make-hubot-hear-other-integration-comment-on-slack) said that it might be implemented within a year.

It really bugged me that there wasn't any hack around this, I really didn't want to wait for a full year to use our shiny Android Widget to open our door.

Then I found out about [SlackBot](https://api.slack.com/slackbot), which is Slacks native (and somewhat limited) bot.

![SlackBot](/images/slackbot.png "SlackBot")

It appears that this Bot has somehow entered userland (Oh how Tron!), and anything SlackBot says is picked up by Hubot as opposed to by other Bots.

And as making SlackBot talk is a simple matter of a POST request, our Android Widget is back in business!

On another small sidenote on the Slack Hubot Adapter, be sure to see this [stackoverflow](https://github.com/slackhq/hubot-slack/issues/106), you'll need to change your Hubot's init script to add the extra `-l` parameter to make sure that mention works as it should...

Cheerioz
