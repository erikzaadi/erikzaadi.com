#!/bin/bash
# Non-master only: print the preview URL (and URLs of posts changed vs master)
# as parseable lines, plus $GITHUB_OUTPUT (preview_url, preview_post_urls) and $GITHUB_STEP_SUMMARY.
SCRIPT_BASE="$( cd -P "$( dirname "$0" )" && pwd )"
PREVIEW_BASE="https://blogpreview.erikzaadi.com/"
PROD_BASE="https://erikzaadi.com/"

if [[ "${GITHUB_REF_NAME}" == "master" ]]; then
    echo "master branch, no preview"
    exit 0
fi

# Posts added or changed compared to master (shallow fetch is enough for a tree diff)
CHANGED=""
if git fetch --no-tags --depth=1 origin master >/dev/null 2>&1; then
    CHANGED=$(git diff --name-only --diff-filter=AMR FETCH_HEAD HEAD -- content/posts | grep '\.md$')
fi

# Map changed files to permalinks via hugo's own CSV listing, so slugs always match the build
POST_URLS=""
if [[ -n "${CHANGED}" ]]; then
    POST_URLS=$(
        for KIND in drafts future published; do
            ${SCRIPT_BASE}/bin/hugo list ${KIND} 2>/dev/null
        done | CHANGED="${CHANGED}" PROD_BASE="${PROD_BASE}" PREVIEW_BASE="${PREVIEW_BASE}" python3 -c '
import csv, os, sys
changed = set(os.environ["CHANGED"].split())
prod, preview = os.environ["PROD_BASE"], os.environ["PREVIEW_BASE"]
seen = []
for row in csv.reader(sys.stdin):
    if len(row) < 8 or row[0] == "path" or row[0] not in changed:
        continue
    url = row[7]
    if url.startswith(prod):
        url = preview + url[len(prod):]
    if url not in seen:
        seen.append(url)
print(" ".join(seen))
'
    )
fi

echo "PREVIEW_URL=${PREVIEW_BASE}"
for URL in ${POST_URLS}; do
    echo "PREVIEW_POST_URL=${URL}"
done

if [[ -n "${GITHUB_OUTPUT}" ]]; then
    echo "preview_url=${PREVIEW_BASE}" >> "${GITHUB_OUTPUT}"
    echo "preview_post_urls=${POST_URLS}" >> "${GITHUB_OUTPUT}"
fi

if [[ -n "${GITHUB_STEP_SUMMARY}" ]]; then
    {
        echo "### Preview deployed: \`${GITHUB_REF_NAME}\`"
        echo ""
        echo "PREVIEW_URL=${PREVIEW_BASE}"
        echo ""
        for URL in ${POST_URLS}; do
            echo "- ${URL}"
        done
    } >> "${GITHUB_STEP_SUMMARY}"
fi
