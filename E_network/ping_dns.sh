#!/usr/bin/env bash
#
# ping_dns.sh
# WGU D796 — RQN1 Task 1, Part E3
# Author: Tonio Jenkins
#
# Purpose:
#   Verify that the local machine can reach Google's public DNS resolver
#   (8.8.8.8) using the ping command.
#
# Usage:
#   ./ping_dns.sh

set -euo pipefail

readonly DNS_IP="8.8.8.8"
readonly COUNT=3
readonly TIMEOUT=5

echo "[INFO] Pinging Google DNS at ${DNS_IP} (${COUNT} packets, ${TIMEOUT}s timeout)..."

if ping -c "${COUNT}" -W "${TIMEOUT}" "${DNS_IP}" >/dev/null 2>&1; then
    echo "Connection to Google DNS (${DNS_IP}) is up."
    exit 0
else
    echo "Connection to Google DNS (${DNS_IP}) failed."
    exit 1
fi
