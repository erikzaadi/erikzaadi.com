#!/bin/bash
HUGO_VERSION=0.18.1
set -x
set -e

mkdir -p "$TRAVIS_BUILD_DIR/gosrc"
go get -v github.com/tdewolff/minify/cmd/minify

# Install Hugo if not already cached or upgrade an old version.
if [ ! -e $TRAVIS_BUILD_DIR/bin/hugo ] || ! [[ `hugo version` =~ v${HUGO_VERSION} ]]; then
  curl -s https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz | tar xvzf -
  mv hugo_${HUGO_VERSION}_linux_amd64/hugo_${HUGO_VERSION}_linux_amd64 $TRAVIS_BUILD_DIR/bin/hugo
fi

