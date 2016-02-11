#!/bin/bash
WANTED_TITLE=${1//[^a-zA-Z0-9]/_}
hugo new posts/$(date +"%Y")/${WANTED_TITLE}.md
