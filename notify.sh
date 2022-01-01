#!/bin/bash
BLOG_URL="https://erikzaadi.com"
MESSAGE="Deploy of blog succeeded"


if [[ "${GITHUB_REF_NAME}" != "master" ]]; then
    BLOG_URL="http://blogpreview.erikzaadi.com"
    MESSAGE="Deploy of preview blog succeeded: '${GITHUB_REF_NAME}'"
else
    aws cloudfront create-invalidation --distribution-id ${AWS_CLOUDFRONT_DISTRIBUTION_ID} --paths "/*" > invalidation.json
    INVALIDATION_ID=$(cat ./invalidation.json | jq '.Invalidation.Id' -r)
    echo "Waiting for invalidation ${INVALIDATION_ID}"
    aws cloudfront wait invalidation-completed --distribution-id ${AWS_CLOUDFRONT_DISTRIBUTION_ID}} --id ${INVALIDATION_ID}
fi
curl -s \
  --form-string "token=${PUSHOVER_TOKEN}" \
  --form-string "user=${PUSHOVER_USER}" \
  --form-string "message=${MESSAGE}" \
  --form-string "url=${BLOG_URL}" \
  https://api.pushover.net/1/messages.json
