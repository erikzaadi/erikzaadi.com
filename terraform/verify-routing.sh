#!/usr/bin/env bash
# Verify the CloudFront routing that replaced the S3 website endpoints, and whether the
# buckets are still reachable directly.
#
# Usage:
#   ./terraform/verify-routing.sh              # phase 1: direct bucket access still allowed
#   EXPECT_PRIVATE=1 ./terraform/verify-routing.sh  # phase 2: direct bucket access must be denied

set -uo pipefail

EXPECT_PRIVATE="${EXPECT_PRIVATE:-0}"
# "domain|bucket|path without trailing slash that exists as a directory"
SITES=(
  "erikzaadi.com|erikzaadi.com|/about"
  "slides.erikzaadi.com|slides.erikzaadi.com|/port-claude-slidev"
  "blogpreview.erikzaadi.com|blogpreview.erikzaadi.com|/about"
)

FAILED=0

check() {
  local label="$1" expected="$2" actual="$3"
  if [[ "$actual" == "$expected" ]]; then
    echo "  PASS - ${label}: ${actual}"
  else
    echo "  FAIL - ${label}: got ${actual}, expected ${expected}"
    FAILED=1
  fi
}

status() {
  curl -s -o /dev/null -w "%{http_code}" --max-time 15 "$@"
}

for SITE in "${SITES[@]}"; do
  IFS='|' read -r DOMAIN BUCKET DIR <<< "$SITE"
  echo "[routing] ${DOMAIN}"

  check "/ serves index" 200 "$(status "https://${DOMAIN}/")"
  check "${DIR}/ serves index" 200 "$(status "https://${DOMAIN}${DIR}/")"

  REDIRECT=$(curl -s -o /dev/null -w "%{http_code} %{redirect_url}" --max-time 15 "https://${DOMAIN}${DIR}")
  check "${DIR} redirects to trailing slash" "301 https://${DOMAIN}${DIR}/" "$REDIRECT"

  check "missing page is a 404" 404 "$(status "https://${DOMAIN}/definitely-not-here-$$/")"
  check "missing file is a 404" 404 "$(status "https://${DOMAIN}/definitely-not-here-$$.css")"

  # Path-style URL, virtual-hosted breaks TLS for bucket names with dots
  DIRECT=$(status "https://s3.us-east-1.amazonaws.com/${BUCKET}/index.html")
  WEBSITE=$(status "http://${BUCKET}.s3-website-us-east-1.amazonaws.com/")
  if [[ "$EXPECT_PRIVATE" == "1" ]]; then
    check "direct bucket access denied" 403 "$DIRECT"
    # 403 while website hosting is still on (private bucket), 404 once it's turned off
    if [[ "$WEBSITE" == "403" || "$WEBSITE" == "404" ]]; then
      echo "  PASS - website endpoint unavailable: ${WEBSITE}"
    else
      echo "  FAIL - website endpoint unavailable: got ${WEBSITE}, expected 403 or 404"
      FAILED=1
    fi
  else
    echo "  INFO - direct bucket access: ${DIRECT}, website endpoint: ${WEBSITE} (public until phase 2)"
  fi
  echo ""
done

exit $FAILED
