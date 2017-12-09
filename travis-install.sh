#!/bin/bash
HUGO_VERSION=0.31.1
set -x
set -e

mkdir -p "$TRAVIS_BUILD_DIR/gosrc"
go get -v github.com/tdewolff/minify/cmd/minify

# Install Hugo if not already cached or upgrade an old version.
if [ ! -e ${TRAVIS_BUILD_DIR}/bin/hugo ] || ! [[ `hugo version` =~ v${HUGO_VERSION} ]]; then
  curl -s -L https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz | tar xvzf -
  https://github.com/gohugoio/hugo/releases/download/v0.31.1/hugo_0.31.1_Linux-64bit.tar.gz
  mv ./hugo ${GOPATH}/bin/hugo
fi
