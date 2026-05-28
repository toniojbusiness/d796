#!/usr/bin/env bash
# Auto-runs once after the Codespace is created. Kept minimal so the boot is fast.
# Most of these tools are already in the base image; we only ensure the few that
# might be missing are present.

set -e

echo "==> Installing missing utilities (this should take <30 seconds)..."
sudo apt-get update -y
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    iputils-ping \
    dnsutils \
    bzip2

echo "==> Marking every .sh in the repo as executable..."
find /workspaces -type f -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true

echo "==> Done."
