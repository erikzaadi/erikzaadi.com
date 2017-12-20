#!/bin/bash
BLOG_URL="https://erikzaadi.com"
MESSAGE="Deploy of blog succeeded"

if [[ "${TRAVIS_BRANCH}" != "master" ]]; then
    BLOG_URL="http://blogpreview.erikzaadi.com"
    MESSAGE="Deploy of preview blog succeeded: '${TRAVIS_BRANCH}'"
fi
curl -X POST https://www.notifymyandroid.com/publicapi/notify -d "apikey=${NMA_TOKEN}&application=Travis&event=${MESSAGE}&description=SUCCESS&url=${BLOG_URL}"
