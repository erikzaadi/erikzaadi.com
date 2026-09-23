#!/bin/bash
set -x
set -e

SCRIPT_BASE="$( cd -P "$( dirname "$0" )" && pwd )"
BIN_DIR="${SCRIPT_BASE}/bin"

if [[ -d ${BIN_DIR} && "${COMMIT_MESSAGE}" == *"clean"* ]]; then
    rm -rf ${BIN_DIR}
fi

# Keep in sync with the local Hugo version (hugo version)
HUGO_VERSION=0.166.0
# From hugo_${HUGO_VERSION}_checksums.txt on the release page
HUGO_SHA256=bb31a43baa959f184877f2408addaba2ff928d967704ed1bb3a38df64bdd6f4e

if [[ ! -d ${BIN_DIR} ]]; then
    mkdir ${BIN_DIR}
fi

cd ${BIN_DIR}

if [[ ! -e ./hugo ]]; then
    HUGO_TARBALL=hugo_extended_withdeploy_${HUGO_VERSION}_Linux-64bit.tar.gz
    curl -sfL -o ${HUGO_TARBALL} https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_TARBALL}
    echo "${HUGO_SHA256}  ${HUGO_TARBALL}" | sha256sum -c -
    tar xvzf ${HUGO_TARBALL}
    rm ${HUGO_TARBALL}
fi

cd ${SCRIPT_BASE}
