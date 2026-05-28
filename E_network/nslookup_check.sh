#!/usr/bin/env bash
#
# nslookup_check.sh
# WGU D796 — RQN1 Task 1, Part E4
# Author: Tonio Jenkins
#
# Purpose:
#   Test that DNS resolution is working for example.com using the nslookup
#   command, and print the resolved IP address.
#
# Usage:
#   ./nslookup_check.sh

set -euo pipefail

readonly DOMAIN="example.com"

if ! command -v nslookup >/dev/null 2>&1; then
    echo "ERROR: nslookup is not installed. Install with: sudo apt install -y dnsutils" >&2
    exit 2
fi

echo "[INFO] Resolving ${DOMAIN} with nslookup..."
if NSLOOKUP_OUTPUT="$(nslookup "${DOMAIN}" 2>&1)"; then
    echo "${NSLOOKUP_OUTPUT}"
    # Pull only the addresses from the answer section (skip the server line).
    RESOLVED_IPS="$(echo "${NSLOOKUP_OUTPUT}" \
        | awk '/^Name:/{flag=1; next} flag && /^Address:/{print $2}')"

    if [[ -n "${RESOLVED_IPS}" ]]; then
        echo
        echo "DNS for ${DOMAIN} is working. Resolved address(es):"
        echo "${RESOLVED_IPS}"
        exit 0
    fi
fi

echo "ERROR: nslookup failed to resolve ${DOMAIN}." >&2
exit 1
