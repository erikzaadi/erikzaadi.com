#!/bin/bash
# Usage: ./notify.sh [success|failure]
STATUS=${1:-success}
BLOG_URL="https://erikzaadi.com"
TARGET="blog"
PRIORITY=0

if [[ "${GITHUB_REF_NAME}" != "master" ]]; then
    BLOG_URL="https://blogpreview.erikzaadi.com"
    TARGET="preview blog: '${GITHUB_REF_NAME}'"
fi

if [[ "${STATUS}" == "failure" ]]; then
    MESSAGE="Deploy of ${TARGET} FAILED"
    # Link to the failed run instead of the site
    BLOG_URL="${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_ID}"
    PRIORITY=1
else
    MESSAGE="Deploy of ${TARGET} succeeded"
fi

curl -s \
  --form-string "token=${PUSHOVER_TOKEN}" \
  --form-string "user=${PUSHOVER_USER}" \
  --form-string "message=${MESSAGE}" \
  --form-string "url=${BLOG_URL}" \
  --form-string "priority=${PRIORITY}" \
  https://api.pushover.net/1/messages.json
