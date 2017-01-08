#!/bin/bash
curl -X POST https://www.notifymyandroid.com/publicapi/notify -d "apikey=${NMA_TOKEN}&application=Travis&event=Deploy of blog succeeded&description=SUCCESS&url=http://erikzaadi.com"
