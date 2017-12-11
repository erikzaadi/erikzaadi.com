#!/bin/bash
if [[ -d ./public ]]; then
    rm -rf ./public
fi
DRAFTS=""
if [[ "$TRAVIS_BRANCH" != "master" ]]; then
    DRAFTS="-D"
fi
$GOPATH/bin/hugo ${DRAFTS}
