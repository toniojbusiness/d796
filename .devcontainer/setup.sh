#!/usr/bin/env bash
# Auto-runs once after the Codespace is created.
# Installs every tool the D796 scripts need and makes the scripts executable.

set -euo pipefail

echo "==> Updating apt index..."
sudo apt-get update -y

echo "==> Installing required packages (vim, dnsutils, iputils-ping, bzip2, gzip, tar)..."
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
    iputils-ping \
    dnsutils \
    bzip2 \
    gzip \
    tar \
    coreutils \
    findutils \
    procps \
    passwd \
    adduser

echo "==> Marking every .sh in the repo as executable..."
find /workspaces -type f -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true

echo "==> Done. The Codespace is ready."
echo "    Read README.md for the per-part instructions."
