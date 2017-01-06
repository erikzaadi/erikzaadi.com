#!/bin/bash
PUBLIC_DIR=public

function minify {
    find ${PUBLIC_DIR} -name $1 -exec echo "Minifying {}" \; -exec minify --html-keep-document-tags -a {} -o {} \;
}

function gzip {
    find ${PUBLIC_DIR} -name $1 -exec echo "Gzipping {}" \; -exec gzip -9 -n {} \; -exec mv {}.gz {} \;
}

minify *.css
minify *.html

gzip *.css
gzip *.js
gzip *.html
