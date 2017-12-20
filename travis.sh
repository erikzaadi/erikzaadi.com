#!/bin/bash
SCRIPT_BASE="$( cd -P "$( dirname "$0" )" && pwd )"
if [[ -d ${SCRIPT_BASE}/public && "${TRAVIS_COMMIT_MESSAGE}" == *"clean"* ]]; then
    rm -rf ${SCRIPT_BASE}/public
fi
DRAFTS=""
if [[ "$TRAVIS_BRANCH" != "master" ]]; then
    DRAFTS="-D -F -b http://blogpreview.erikzaadi.com/"
fi
${SCRIPT_BASE}/bin/hugo ${DRAFTS}
