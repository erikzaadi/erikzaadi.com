#!/bin/bash
TARGET_BUCKET=erikzaadi.com
if [[ "${GITHUB_REF_NAME}" != "master" ]]; then
    TARGET_BUCKET="blogpreview.erikzaadi.com"
fi
aws s3 sync --delete --follow-symlinks --acl public-read ./public s3://${TARGET_BUCKET}/
