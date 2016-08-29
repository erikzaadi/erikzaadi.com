#!/bin/bash
WANTED_TITLE=${1//[^a-zA-Z0-9]/-}
hugo new posts/$(date +"%Y")/${WANTED_TITLE}.md --editor=${EDITOR}
