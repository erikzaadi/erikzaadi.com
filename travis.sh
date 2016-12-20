#!/bin/bash
if [[ -d ./public ]]; then
    rm -rf ./public
fi
$GOPATH/bin/hugo
