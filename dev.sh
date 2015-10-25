#!/bin/bash
if [[ -d ./public ]]; then
    rm -rf ./public
fi
hugo server -w
