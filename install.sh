#!/bin/bash
set -x
set -e

SCRIPT_BASE="$( cd -P "$( dirname "$0" )" && pwd )"
BIN_DIR="${SCRIPT_BASE}/bin"

if [[ -d ${BIN_DIR} &&  "${COMMIT_MESSAGE}" == *"clean"* ]]; then
    rm -rf ${BIN_DIR}
fi

HUGO_VERSION=0.148.0
MINIFY_VERSION=2.3.4
JQ_VERSION=1.6

if [[ ! -d ${BIN_DIR} ]]; then
    mkdir ${BIN_DIR}
fi

function install_from_github_release() {
    REPO=$1
    EXECUTABLE=$2
    VERSION=$3
    TAR_SUFFIX=$4
    cd ${BIN_DIR}
    if [[ ! -e ./${EXECUTABLE} ]]; then
      curl -s -L https://github.com/${REPO}/releases/download/v${VERSION}/${EXECUTABLE}_${VERSION}_${TAR_SUFFIX}.tar.gz | tar xvzf -
    fi
    cd ${SCRIPT_BASE}
}

install_from_github_release gohugoio/hugo hugo ${HUGO_VERSION} Linux-64bit
install_from_github_release tdewolff/minify minify ${MINIFY_VERSION} linux_amd64

# JQ gotta be special
cd ${BIN_DIR}
curl -s -L https://github.com/stedolan/jq/releases/download/jq-v${JQ_VERSION}/jq-linux64 --output ./jq
chmod a+x ./jq
cd ${SCRIPT_BASE}

pip install -U pip
pip install -U awscli
aws configure set preview.cloudfront true
