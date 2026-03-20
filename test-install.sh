#!/bin/bash
set -e

PORT=${1:-8080}

echo "Building and serving blog on http://localhost:${PORT}"

docker run --rm \
    --platform linux/amd64 \
    -v $(pwd):/blog \
    -w /blog \
    -p ${PORT}:${PORT} \
    ubuntu:latest \
    bash -c "
        apt-get update -q &&
        apt-get install -y -q curl &&
        COMMIT_MESSAGE=clean ./install.sh &&
        echo '--- Versions ---' &&
        ./bin/hugo version &&
        ./bin/minify --version &&
        ./bin/jq --version &&
        echo '--- Compiling ---' &&
        GITHUB_REF_NAME=preview COMMIT_MESSAGE='' ./ci.sh &&
        echo '--- Minifying (no gzip for local serving) ---' &&
        find ./public -name '*.css' -exec ./bin/minify --html-keep-document-tags -a {} -o {} \; &&
        find ./public -name '*.html' -exec ./bin/minify --html-keep-document-tags -a {} -o {} \; &&
        echo '--- Serving on port ${PORT} ---' &&
        python3 -m http.server ${PORT} --directory ./public
    "
