#!/bin/bash
set -x
set -e

SCRIPT_BASE="$( cd -P "$( dirname "$0" )" && pwd )"
BIN_DIR="${SCRIPT_BASE}/bin"

if [[ -d ${BIN_DIR} && "${COMMIT_MESSAGE}" == *"clean"* ]]; then
    rm -rf ${BIN_DIR}
fi

HUGO_VERSION=0.158.0
MINIFY_VERSION=2.24.10
JQ_VERSION=1.8.1

if [[ ! -d ${BIN_DIR} ]]; then
    mkdir ${BIN_DIR}
fi

cd ${BIN_DIR}

if [[ ! -e ./hugo ]]; then
    curl -s -L https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_withdeploy_${HUGO_VERSION}_Linux-64bit.tar.gz | tar xvzf -
fi

if [[ ! -e ./minify ]]; then
    curl -s -L https://github.com/tdewolff/minify/releases/download/v${MINIFY_VERSION}/minify_linux_amd64.tar.gz | tar xvzf -
fi

if [[ ! -e ./jq ]]; then
    curl -s -L https://github.com/jqlang/jq/releases/download/jq-${JQ_VERSION}/jq-linux-amd64 --output ./jq
    chmod a+x ./jq
fi

cd ${SCRIPT_BASE}

