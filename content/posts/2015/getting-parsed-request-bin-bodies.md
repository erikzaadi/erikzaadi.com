---
date: 2015-11-11T13:54:56+02:00
description: "Piping Request.bin to jq to node to awesomeness"
title: Getting parsed Request Bin bodies
---

**TL;DR** 

```bash
curl -s 'http://requestb.in/api/v1/bins/YOUR_BIN_ID/requests' | jq '.[] | .body' | node -e 'var counter=0;require("readline").createInterface({input: process.stdin}).on("line", function (line) { require("fs").writeFileSync((++counter).toString() + ".json", JSON.parse(line));});'
```

## You should be using [RequestBin](http://requestb.in/)!!1

RequestBin is a free service offered by [RunScope](https://runscope.com), where you can register a temporary web endpoint, that'll record anything sent to it.
It saves you the effort of setting up a [ngrok](https://ngrok.com/) and a local endpoint.

I was using it to see the results of a 3rd party integration I was working on.

As RequestBin only lives for 48 hours, I wanted to get all the request body made to the bin, which in my case were `POST` requests with a JSON body.

Luckily, RequestBin has a an API:

`http://requestb.in/api/v1/bins/YOUR_CREATED_BIN_ID`

**NOTE**: 'If you created a private bin, you'll need to add the session cookie in your `curl` request:

```bash
curl -s 'http://requestb.in/api/v1/bins/YOUR_BIN_ID/requests' -H 'Cookie: session=BLAAAAAAAAAAAAAAAAAAAAAAAAAAA' 
```

### And BOOM:

```json
{
  "remote_addr": "IP.00.0.000",
  "method": "POST",
  "raw": "{\n  \"way_longer_raw_json_body_that_I_will_not_bore_you_with\":                 true\n}",
  "id": "1zzzzz",
  "headers": {
    "X-Request-Id": "b0067d65-73d4-4b21-afc9-c8129ed5bf2f",
    "Connect-Time": "1",
    "Accept-Encoding": "gzip,deflate",
    "Host": "requestb.in",
    "User-Agent": "Apache-HttpClient/4.3.6 (java 1.5)",
    "Total-Route-Time": "0",
    "Connection": "close",
    "Content-Type": "application/javascript; charset=UTF-8",
    "Via": "1.1 vegur",
    "Content-Length": "2300",
  },
  "form_data": {},
  "content_length": 2300,
  "query_string": {
    "ZOMG": [
      "TOTALLIZ"
    ]
  },
  "path": "/YOUR_BIN_ID",
  "content_type": "application/javascript; charset=UTF-8",
  "body": "{\n  \"way_longer_raw_json_body_that_I_will_not_bore_you_with\":                 true\n}",
  "time": 1447243787.943264
}
```


### Yaay we got a lot of raw strings!

Ok awesome, now I had loads of info, but all I was interested of was the JSON body.

### jq to the rescue

[jq](https://stedolan.github.io/jq/) is `sed|grep|awk` for JSON.

A simple pipe with a selector filtered the request

```bash
curl -s 'http://requestb.in/api/v1/bins/YOUR_BIN_ID/requests' | jq '.[] | .body' 
```

### BADABIM BADABOOM, SO MUCH DOGE, SO MUCH RAW JSON

But goosh, those are still raw strings, would love to parse them.

Let's pipe them through `node`!

**NOTE**: needs `node` v0.12 and up..

```javascript
var counter=0;
require("readline").createInterface(
  {
    input: process.stdin
  })
  .on("line", function (line) { 
    require("fs").writeFileSync((++counter).toString() + ".json", JSON.parse(line));
  });
```

### To summarize

```bash
curl -s 'http://requestb.in/api/v1/bins/YOUR_BIN_ID/requests' | jq '.[] | .body' | node -e 'var counter=0;require("readline").createInterface({input: process.stdin}).on("line", function (line) { require("fs").writeFileSync((++counter).toString() + ".json", JSON.parse(line));});'
```

And you'll have `N.json` files with the parsed bodies.
