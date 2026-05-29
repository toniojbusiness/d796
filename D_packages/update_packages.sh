#!/usr/bin/env bash
#
# update_packages.sh
# WGU D796 — RQN1 Task 1, Part D2
# Author: Tonio Jenkins
#
# Purpose:
#   Update all installed packages on a Debian/Ubuntu system using apt and
#   save the full output to update.log in the current working directory.
#
# Usage:
#   sudo ./update_packages.sh           # demo mode: refresh package lists +
#                                       #   simulated upgrade. Fast, safe in
#                                       #   shared sandboxes (Killercoda etc.)
#   sudo ./update_packages.sh --real    # actually apply the upgrade.
#
# The demo mode produces real apt output (showing every package that WOULD
# be upgraded) and writes it to update.log, which is what rubric D2
# requires. The --real flag is provided for production use.

set -euo pipefail

readonly LOGFILE="update.log"
MODE="demo"

if [[ "${1:-}" == "--real" ]]; then
    MODE="real"
fi

if [[ "$(id -u)" -ne 0 ]]; then
    echo "ERROR: This script must be run as root (use sudo)." >&2
    exit 1
fi

echo "[INFO] Mode: ${MODE}"
echo "[INFO] Updating package lists and ${MODE} upgrading installed packages..."
echo "[INFO] Output will be saved to: $(pwd)/${LOGFILE}"

# Truncate (or create) the log file with a banner.
{
    echo "============================================================"
    echo "Package update log"
    echo "Date:   $(date)"
    echo "Host:   $(hostname)"
    echo "Mode:   ${MODE}"
    echo "============================================================"
} > "${LOGFILE}"

# Run apt operations and capture both stdout and stderr.
{
    DEBIAN_FRONTEND=noninteractive apt-get update -y
    echo "------------------------------------------------------------"
    if [[ "${MODE}" == "real" ]]; then
        DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
        echo "------------------------------------------------------------"
        DEBIAN_FRONTEND=noninteractive apt-get autoremove -y
    else
        # Simulated upgrade. Lists everything that WOULD be upgraded without
        # actually downloading or installing — fast and sandbox-safe.
        DEBIAN_FRONTEND=noninteractive apt-get -s upgrade
    fi
} >> "${LOGFILE}" 2>&1

echo "[OK]   Update complete. Log saved to ${LOGFILE}."
echo "[INFO] Last 15 lines of ${LOGFILE}:"
tail -n 15 "${LOGFILE}"
exit 0
