#!/bin/bash
SCRIPT_BASE="$( cd -P "$( dirname "$0" )" && pwd )"
PUBLIC_DIR=${SCRIPT_BASE}/public

function minify {
    find ${PUBLIC_DIR} -name $1 -exec echo "Minifying {}" \; -exec ${SCRIPT_BASE}/bin/minify --html-keep-document-tags -a {} -o {} \;
}

function gzip {
    find ${PUBLIC_DIR} -name $1 -exec echo "Gzipping {}" \; -exec gzip -9 -n {} \; -exec mv {}.gz {} \;
}

minify *.css
minify *.html

gzip *.css
gzip *.js
gzip *.html
