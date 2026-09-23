#!/usr/bin/env bash
# Verify the live TLS certificate for each domain via openssl.
# Checks the cert matches the domain, is not expiring soon, and is issued by Amazon (ACM).
#
# Usage:
#   ./terraform/verify-certs.sh [domain...]
#
#   Defaults to erikzaadi.com, slides.erikzaadi.com and blogpreview.erikzaadi.com
#   MIN_DAYS    - fail if fewer days are left (default 30)
#   EXPECT_ISSUER - issuer substring to require (default "Amazon", set empty to skip)

set -uo pipefail

DOMAINS=("$@")
if [[ ${#DOMAINS[@]} -eq 0 ]]; then
  DOMAINS=(erikzaadi.com slides.erikzaadi.com blogpreview.erikzaadi.com)
fi
MIN_DAYS="${MIN_DAYS:-30}"
EXPECT_ISSUER="${EXPECT_ISSUER-Amazon}"

to_epoch() {
  # openssl notAfter format: "Nov 25 17:27:03 2026 GMT"
  date -d "$1" +%s 2>/dev/null || date -j -f "%b %d %T %Y %Z" "$1" +%s
}

FAILED=0

for DOMAIN in "${DOMAINS[@]}"; do
  echo "[cert] ${DOMAIN}"

  CERT=$(echo | openssl s_client -connect "${DOMAIN}:443" -servername "${DOMAIN}" 2>/dev/null \
    | openssl x509 2>/dev/null)
  if [[ -z "$CERT" ]]; then
    echo "  FAIL - could not fetch certificate"
    FAILED=1
    continue
  fi

  ISSUER=$(openssl x509 -noout -issuer <<< "$CERT" | sed 's/^issuer=//')
  NOT_AFTER=$(openssl x509 -noout -enddate <<< "$CERT" | sed 's/^notAfter=//')
  DAYS_LEFT=$(( ($(to_epoch "$NOT_AFTER") - $(date +%s)) / 86400 ))

  echo "  Issuer:  ${ISSUER}"
  echo "  Expires: ${NOT_AFTER} (${DAYS_LEFT} days)"

  if openssl x509 -noout -checkhost "${DOMAIN}" <<< "$CERT" | grep -q "does match"; then
    echo "  PASS - certificate matches ${DOMAIN}"
  else
    echo "  FAIL - certificate does not match ${DOMAIN}"
    FAILED=1
  fi

  if (( DAYS_LEFT >= MIN_DAYS )); then
    echo "  PASS - more than ${MIN_DAYS} days left"
  else
    echo "  FAIL - less than ${MIN_DAYS} days left"
    FAILED=1
  fi

  if [[ -n "$EXPECT_ISSUER" ]]; then
    if [[ "$ISSUER" == *"$EXPECT_ISSUER"* ]]; then
      echo "  PASS - issued by ${EXPECT_ISSUER}"
    else
      echo "  FAIL - expected issuer containing \"${EXPECT_ISSUER}\""
      FAILED=1
    fi
  fi
  echo ""
done

exit $FAILED
