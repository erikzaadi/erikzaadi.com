#!/bin/bash
BLOG_URL="http://erikzaadi.com"
MESSAGE="Deploy of blog succeeded"

if [[ "${TRAVIS_BRANCH}" = "preview" ]]; then
    BLOG_URL="http://blogpreview.erikzaadi.com"
    MESSAGE="Deploy of preview blog succeeded"
fi
curl -X POST https://www.notifymyandroid.com/publicapi/notify -d "apikey=${NMA_TOKEN}&application=Travis&event=${MESSAGE}&description=SUCCESS&url=${BLOG_URL}"
