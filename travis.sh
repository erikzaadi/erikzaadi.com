#!/bin/bash
SCRIPT_BASE="$( cd -P "$( dirname "$0" )" && pwd )"
if [[ -d ${SCRIPT_BASE}/public ]]; then
    rm -rf ${SCRIPT_BASE}/public
fi
DRAFTS=""
if [[ "$TRAVIS_BRANCH" = "preview" ]]; then
    DRAFTS="-D -b http://blogpreview.erikzaadi.com/"
fi
${SCRIPT_BASE}/bin/hugo ${DRAFTS}
