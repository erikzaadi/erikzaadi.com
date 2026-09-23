#!/bin/bash
set -e

PORT=${1:-8080}
# Same Ubuntu release as the build job's runs-on in .github/workflows/main.yml, bump both together

echo "Building and serving blog on http://localhost:${PORT}"

docker run --rm \
    --platform linux/amd64 \
    -v $(pwd):/blog \
    -w /blog \
    -p ${PORT}:${PORT} \
    ubuntu:24.04 \
    bash -c "
        apt-get update -q &&
        apt-get install -y -q curl python3 &&
        COMMIT_MESSAGE=clean ./install.sh &&
        echo '--- Versions ---' &&
        ./bin/hugo version &&
        echo '--- Compiling ---' &&
        GITHUB_REF_NAME=preview COMMIT_MESSAGE='' ./ci.sh &&
        echo '--- Serving on port ${PORT} ---' &&
        python3 -m http.server ${PORT} --directory ./public
    "
