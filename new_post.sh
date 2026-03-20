#!/bin/bash
WANTED_TITLE=${1//[^a-zA-Z0-9]/-}
FILE="content/posts/$(date +"%Y")/${WANTED_TITLE}.md"
hugo new "${FILE}"
echo "${FILE}"
