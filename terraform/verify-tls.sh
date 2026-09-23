#!/usr/bin/env bash
# Verify the CloudFront TLS policy (TLSv1.2_2021) is live for each domain.
# Checks TLS 1.2/1.3 are accepted, TLS 1.0/1.1 and weak CBC ciphers are refused by the server.
#
# Usage:
#   ./terraform/verify-tls.sh [domain...]
#
#   Defaults to erikzaadi.com, slides.erikzaadi.com and blogpreview.erikzaadi.com
#   Needs an OpenSSL build (not LibreSSL) that can still offer TLS 1.0/1.1 at SECLEVEL=0,
#   otherwise those checks are reported as INCONCLUSIVE rather than PASS.

set -uo pipefail

DOMAINS=("$@")
if [[ ${#DOMAINS[@]} -eq 0 ]]; then
  DOMAINS=(erikzaadi.com slides.erikzaadi.com blogpreview.erikzaadi.com)
fi

FAILED=0

# Prints: accepted | refused | local (this openssl can't offer the protocol/cipher)
probe() {
  local domain="$1"
  shift
  local out
  out=$(echo | openssl s_client -connect "${domain}:443" -servername "${domain}" "$@" 2>&1)
  if grep -qE "no protocols available|no ciphers available|unknown option|null ssl method" <<< "$out"; then
    echo "local"
  elif grep -qE "Cipher is \(NONE\)|alert|handshake failure" <<< "$out"; then
    echo "refused"
  elif grep -qE "Cipher is " <<< "$out"; then
    echo "accepted"
  else
    echo "local"
  fi
}

check() {
  local label="$1" expected="$2" result="$3"
  if [[ "$result" == "$expected" ]]; then
    echo "  PASS - ${label} ${result}"
  elif [[ "$result" == "local" ]]; then
    echo "  INCONCLUSIVE - ${label}: local openssl can't test this"
  else
    echo "  FAIL - ${label} ${result}, expected ${expected}"
    FAILED=1
  fi
}

openssl version
echo ""

for DOMAIN in "${DOMAINS[@]}"; do
  echo "[tls] ${DOMAIN}"
  check "TLS 1.3" accepted "$(probe "$DOMAIN" -tls1_3)"
  check "TLS 1.2" accepted "$(probe "$DOMAIN" -tls1_2)"
  check "TLS 1.1" refused "$(probe "$DOMAIN" -tls1_1 -cipher 'DEFAULT@SECLEVEL=0')"
  check "TLS 1.0" refused "$(probe "$DOMAIN" -tls1 -cipher 'DEFAULT@SECLEVEL=0')"
  # Allowed under TLSv1.1_2016, dropped in TLSv1.2_2021 (CBC + SHA1)
  check "TLS 1.2 ECDHE-RSA-AES128-SHA" refused "$(probe "$DOMAIN" -tls1_2 -cipher 'ECDHE-RSA-AES128-SHA')"
  echo ""
done

exit $FAILED
