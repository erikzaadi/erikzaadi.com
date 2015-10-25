#!/bin/bash
if [[ -d ./public ]]; then
    rm -r ./public
fi
hugo
s3-cli sync --delete-removed ./public s3://erikzaadi.com/
