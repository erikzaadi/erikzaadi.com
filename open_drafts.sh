#!/bin/bash
SCRIPT_BASE="$( cd -P "$( dirname "$0" )" && pwd )"
DRAFTS=($(grep -l 'draft: true' ${SCRIPT_BASE}/content/posts/**/*.md))
IFS=" "
vim -O ${DRAFTS[*]}
