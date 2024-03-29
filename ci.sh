#!/bin/bash
SCRIPT_BASE="$( cd -P "$( dirname "$0" )" && pwd )"
if [[ -d ${SCRIPT_BASE}/public && "${COMMIT_MESSAGE}" == *"clean"* ]]; then
    rm -rf ${SCRIPT_BASE}/public
fi
DRAFTS=""
if [[ "${GITHUB_REF_NAME}" != "master" ]]; then
    DRAFTS="-D -F -b http://blogpreview.erikzaadi.com/"
fi
${SCRIPT_BASE}/bin/hugo ${DRAFTS} --noTimes
