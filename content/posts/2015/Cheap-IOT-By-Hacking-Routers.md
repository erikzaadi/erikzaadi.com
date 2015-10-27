---
date: 2015-10-27T17:48:45+02:00
description: "One must make effort to be lazy"
title: Cheap IOT By Hacking Routers
categories: [iot, raspberrypi, bigpanda]
---

As I [previously](/2015/03/05/raspberry-pi-powered-door) blogged about, we have a Raspberry Pi at BigPanda that opens our office door.

We even created an Android widget to open the door from the outside, so it'll be as easy as possible.

**ALAS**, this was not enough, [Noam Shemesh](http://noamsh.com/) (the mighty) felt that the effort of actually taking out your mobile phone when approching the door is tedious.

*IOT* to the rescue!

We needed to have some kind of sensor that we're approaching the door from the outside, and of course be secure (*ish*).

**AHA! WIFI!!!1**

The routers have a device list, now if only their API was documented and open.

NOT.

Oh well, time to improvise.

After sniffing the network requests from the admin GUI, testing a bit with `curl`, we had a way of knowing not only what clients are connected, but also retrieve their MAC addresses, and the last time the devices connection changed.

We wrote a swift hack in node, which pulls the device list and manage a state of connected items, and checks if there's any new connections for whitelisted MAC addresses. 

If so we open the door.

**BEHOLD, ZE FUGLY HACK**

```
var request = require('request');
var _ = require('lodash');
var Promise = require('bluebird');
var routers = ['XXX.XX.XX.XXX', 'YYY.YY.YY.YYY'];

var whiteList = ['FF:FF:FF:FF:FF:FF', 'AA:AA:AA:AA:AA:AA'];

var devices = {};

function getOptions(router){
  return {
    url: 'http://' + router + '/JNAP/',
    headers: {
      'X-JNAP-Authorization': 'Basic WHYOWHYBASE64PASSWORD=',
      'X-JNAP-Action': 'http://cisco.com/jnap/core/Transaction',
    },
    json: [{"action":"http://cisco.com/jnap/devicelist/GetDevices","request":{"sinceRevision":0}},{"action":"http://cisco.com/jnap/networkconnections/GetNetworkConnections","request":{}}]
  };
}

var openDoor = function(){
  request('http://ZZZ.ZZ.ZZZ.ZZZ/api/open');
}

function getDevicesFromResult(body){
  return _.chain(
      body.responses)
        .pluck('output')
        .pluck('devices')
        .flatten()
        .filter(function(device){
          return device && device.connections && device.connections.length > 0;
        })
        .map(function(device){
          return {
            MAC: device.knownMACAddresses[0],
            name: device.friendlyName,
            lastChange: device.lastChangeRevision
          };
        })
        .filter(function(device){
          return whiteList.indexOf(device.MAC) >= 0;
        })
        .value();
}

function handleGotOnline(device){
  console.log(device, 'got online');
  openDoor();
}


function handleDevices(onlineDevices){
  _.each(onlineDevices, function(device){
    if (!devices[device.MAC]){
      devices[device.MAC] = device;
    }

    var theDevice = devices[device.MAC];
    if (device.lastChange > theDevice.lastChange){
      devices[device.MAC].lastChange = device.lastChange;
      handleGotOnline(device);
    }
  });
  setTimeout(promptRouters, 1000);
}


function callback(response) {
  return getDevicesFromResult(response.body);
}

var postPromise = Promise.promisify(request.post);

function promptRouters(){
  console.log("prompting");
  Promise.all(
      _.map(routers, function(router) {
        return postPromise(getOptions(router))
          .then(callback);
      }
      )).then(function(results){
        var onlineDevices = _.flatten(results);
        console.log("got results", onlineDevices.length);
        handleDevices(onlineDevices);
      });
}

promptRouters();
```
