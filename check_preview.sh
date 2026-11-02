#!/bin/bash
# Usage: ./check_preview.sh URL [URL...]
# Fails if any URL doesn't answer HTTP 200 (a few retries, the preview has caching disabled)
FAILED=0
for URL in "$@"; do
    STATUS=000
    for ATTEMPT in 1 2 3 4 5; do
        STATUS=$(curl -s -o /dev/null -w '%{http_code}' --max-time 20 "${URL}")
        [[ "${STATUS}" == "200" ]] && break
        sleep 5
    done
    echo "HTTP ${STATUS} ${URL}"
    if [[ "${STATUS}" != "200" ]]; then
        echo "::error::Preview check failed: HTTP ${STATUS} for ${URL}"
        FAILED=1
    fi
done
exit ${FAILED}
