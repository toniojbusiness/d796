#!/usr/bin/env bash
#
# disk_cleanup.sh
# WGU D796 — RQN1 Task 1, Part F
# Author: Tonio Jenkins
#
# Purpose:
#   Assess and clean up disk space.
#     1. Capture available KB on the root partition (df) before cleanup.
#     2. Define cleanDir() — wipes the contents of the supplied directory.
#     3. Iterate over a list of directories and call cleanDir() on each.
#     4. Capture available KB after cleanup and report the difference.
#
# Usage:
#   sudo ./disk_cleanup.sh

set -uo pipefail

if [[ "$(id -u)" -ne 0 ]]; then
    echo "ERROR: This script must be run as root (use sudo)." >&2
    exit 1
fi

# ---------------------------------------------------------------------------
# F1. Find the free disk space in the root partition using df and store it
#     in a variable (in 1K blocks).
# ---------------------------------------------------------------------------
SPACE_BEFORE_KB="$(df --output=avail / | tail -n 1 | tr -d ' ')"
SPACE_BEFORE_HUMAN="$(df -h --output=avail / | tail -n 1 | tr -d ' ')"

echo "============================================================"
echo "Disk cleanup — start"
echo "Free space on / before cleanup: ${SPACE_BEFORE_HUMAN} (${SPACE_BEFORE_KB} KB)"
echo "============================================================"

# ---------------------------------------------------------------------------
# F2. cleanDir() — delete the contents of the directory passed as the first
#     argument. Hidden files are removed too. The directory itself is kept.
# ---------------------------------------------------------------------------
cleanDir() {
    local target_dir="$1"

    if [[ -z "${target_dir}" ]]; then
        echo "  [WARN] cleanDir called with no argument; skipping."
        return 1
    fi

    if [[ ! -d "${target_dir}" ]]; then
        echo "  [WARN] ${target_dir} does not exist; skipping."
        return 1
    fi

    echo "  [INFO] Cleaning ${target_dir} ..."
    # Use find so we don't choke on dotfiles; -mindepth 1 keeps the dir itself.
    find "${target_dir}" -mindepth 1 -maxdepth 10 \
        -exec rm -rf {} + 2>/dev/null || true
    echo "  [OK]   ${target_dir} cleaned."
}

# ---------------------------------------------------------------------------
# F3. List of directories to clean.
# ---------------------------------------------------------------------------
DIRS_TO_CLEAN=(
    "/var/log"
    "${HOME}/.cache"
    "/tmp"
)

echo
echo "Directories to clean:"
printf '  - %s\n' "${DIRS_TO_CLEAN[@]}"
echo

# ---------------------------------------------------------------------------
# F4. Iterate and clean.
# ---------------------------------------------------------------------------
for dir in "${DIRS_TO_CLEAN[@]}"; do
    cleanDir "${dir}"
done

# ---------------------------------------------------------------------------
# F5. Re-measure free space and report the difference.
# ---------------------------------------------------------------------------
SPACE_AFTER_KB="$(df --output=avail / | tail -n 1 | tr -d ' ')"
SPACE_AFTER_HUMAN="$(df -h --output=avail / | tail -n 1 | tr -d ' ')"

echo
echo "============================================================"
echo "Disk cleanup — done"
echo "Free space on / after cleanup:  ${SPACE_AFTER_HUMAN} (${SPACE_AFTER_KB} KB)"
echo "============================================================"

DIFF_KB=$(( SPACE_AFTER_KB - SPACE_BEFORE_KB ))

if (( DIFF_KB > 0 )); then
    DIFF_MB=$(( DIFF_KB / 1024 ))
    echo "Freed ${DIFF_KB} KB (~${DIFF_MB} MB) of disk space."
else
    echo "No significant disk space was freed"
fi

exit 0
