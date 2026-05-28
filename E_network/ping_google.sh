#!/usr/bin/env bash
#
# ping_google.sh
# WGU D796 — RQN1 Task 1, Part E2
# Author: Tonio Jenkins
#
# Purpose:
#   Check that the system can reach google.com by sending a small number of
#   ICMP echo requests. Print "Network is up." if the host responds.
#
# Usage:
#   ./ping_google.sh

set -euo pipefail

readonly TARGET="google.com"
readonly COUNT=3       # send 3 packets
readonly TIMEOUT=5     # seconds to wait for a reply per packet

echo "[INFO] Pinging ${TARGET} (${COUNT} packets, ${TIMEOUT}s timeout)..."

if ping -c "${COUNT}" -W "${TIMEOUT}" "${TARGET}" >/dev/null 2>&1; then
    echo "Network is up."
    exit 0
else
    echo "Network is down. Could not reach ${TARGET}."
    exit 1
fi
