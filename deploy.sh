#!/bin/bash
# Upload changed files only (MD5 compare), Cache-Control per deployment.matchers in config.yaml.
# Production also invalidates CloudFront and waits, so the notification means it's live.
set -e
SCRIPT_BASE="$( cd -P "$( dirname "$0" )" && pwd )"

TARGET=production
if [[ "${GITHUB_REF_NAME}" != "master" ]]; then
    TARGET=preview
fi

# "clean" in the commit message re-uploads everything, e.g. after changing the matchers
FORCE=""
if [[ "${COMMIT_MESSAGE}" == *"clean"* ]]; then
    FORCE="--force"
fi

${SCRIPT_BASE}/bin/hugo deploy --target ${TARGET} ${FORCE}

# The preview distribution has caching disabled, no invalidation needed
if [[ "${TARGET}" == "production" ]]; then
    INVALIDATION_ID=$(aws cloudfront create-invalidation --distribution-id ${AWS_CLOUDFRONT_DISTRIBUTION_ID} --paths "/*" --query Invalidation.Id --output text)
    echo "Waiting for invalidation ${INVALIDATION_ID}"
    aws cloudfront wait invalidation-completed --distribution-id ${AWS_CLOUDFRONT_DISTRIBUTION_ID} --id ${INVALIDATION_ID}
fi
