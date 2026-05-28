#!/usr/bin/env bash
#
# install_vim.sh
# WGU D796 — RQN1 Task 1, Part D1
# Author: Tonio Jenkins
#
# Purpose:
#   Install the vim package on a Debian/Ubuntu system. If vim is already
#   installed, print "Vim is already installed" and exit.
#
# Usage:
#   sudo ./install_vim.sh

set -euo pipefail

readonly PACKAGE="vim"

if [[ "$(id -u)" -ne 0 ]]; then
    echo "ERROR: This script must be run as root (use sudo)." >&2
    exit 1
fi

# dpkg -s returns 0 only when the package is fully installed.
if dpkg -s "${PACKAGE}" 2>/dev/null | grep -q "^Status: install ok installed"; then
    echo "Vim is already installed"
    vim --version | head -1
    exit 0
fi

echo "[INFO] Vim is not installed. Installing now..."
apt-get update -y
DEBIAN_FRONTEND=noninteractive apt-get install -y "${PACKAGE}"

echo "[OK]   Vim installed successfully."
vim --version | head -1
exit 0
