#!/bin/bash
BLOG_URL="https://erikzaadi.com"
MESSAGE="Deploy of blog succeeded"

if [[ "${TRAVIS_BRANCH}" != "master" ]]; then
    BLOG_URL="http://blogpreview.erikzaadi.com"
    MESSAGE="Deploy of preview blog succeeded: '${TRAVIS_BRANCH}'"
fi
curl -s \
  --form-string "token=${PUSHOVER_TOKEN}" \
  --form-string "user=${PUSHOVER_USER}" \
  --form-string "message=${MESSAGE}" \
  --form-string "url=${BLOG_URL}" \
  https://api.pushover.net/1/messages.json
