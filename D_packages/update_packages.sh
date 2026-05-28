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
#   sudo ./update_packages.sh

set -euo pipefail

readonly LOGFILE="update.log"

if [[ "$(id -u)" -ne 0 ]]; then
    echo "ERROR: This script must be run as root (use sudo)." >&2
    exit 1
fi

echo "[INFO] Updating package lists and upgrading installed packages..."
echo "[INFO] Output will be saved to: $(pwd)/${LOGFILE}"

# Truncate (or create) the log file with a banner.
{
    echo "============================================================"
    echo "Package update log"
    echo "Date: $(date)"
    echo "Host: $(hostname)"
    echo "============================================================"
} > "${LOGFILE}"

# Run update + upgrade noninteractively, capturing both stdout and stderr.
{
    DEBIAN_FRONTEND=noninteractive apt-get update -y
    echo "------------------------------------------------------------"
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
    echo "------------------------------------------------------------"
    DEBIAN_FRONTEND=noninteractive apt-get autoremove -y
} >> "${LOGFILE}" 2>&1

echo "[OK]   Update complete. Log saved to ${LOGFILE}."
echo "[INFO] Last 10 lines of ${LOGFILE}:"
tail -n 10 "${LOGFILE}"
exit 0
