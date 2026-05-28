#!/usr/bin/env bash
#
# archive_etc.sh
# WGU D796 — RQN1 Task 1, Part G
# Author: Tonio Jenkins
#
# Purpose:
#   Archive and compress /etc using both gzip and bzip2, then report the
#   size of each compressed archive (using a fileSize() function) and the
#   difference between the two compression algorithms.
#
# Usage:
#   sudo ./archive_etc.sh

set -uo pipefail

if [[ "$(id -u)" -ne 0 ]]; then
    echo "ERROR: This script must be run as root (use sudo)." >&2
    exit 1
fi

readonly OUTDIR="/tmp"
readonly GZIP_ARCHIVE="${OUTDIR}/etc_backup.tar.gz"
readonly BZIP2_ARCHIVE="${OUTDIR}/etc_backup.tar.bz2"

# ---------------------------------------------------------------------------
# G1. fileSize() — return the size, in bytes, of the file given as $1.
# ---------------------------------------------------------------------------
fileSize() {
    local target="$1"

    if [[ -z "${target}" ]]; then
        echo "ERROR: fileSize requires a filename." >&2
        return 1
    fi

    if [[ ! -f "${target}" ]]; then
        echo "ERROR: ${target} is not a regular file." >&2
        return 1
    fi

    # stat -c%s works on GNU coreutils (Linux). Output: size in bytes.
    stat -c%s "${target}"
}

# Friendly human-readable size for display.
humanSize() {
    local bytes="$1"
    numfmt --to=iec --suffix=B --padding=7 "${bytes}" 2>/dev/null \
        || echo "${bytes} bytes"
}

# ---------------------------------------------------------------------------
# G2. Archive + compress /etc with gzip.
# ---------------------------------------------------------------------------
echo "============================================================"
echo "Archiving /etc with tar + gzip ..."
echo "------------------------------------------------------------"
rm -f "${GZIP_ARCHIVE}"
tar -czf "${GZIP_ARCHIVE}" -C / etc 2>/dev/null
echo "[OK]   Created ${GZIP_ARCHIVE}"

# ---------------------------------------------------------------------------
# G3. Archive + compress /etc with bzip2.
# ---------------------------------------------------------------------------
echo
echo "============================================================"
echo "Archiving /etc with tar + bzip2 ..."
echo "------------------------------------------------------------"
rm -f "${BZIP2_ARCHIVE}"
tar -cjf "${BZIP2_ARCHIVE}" -C / etc 2>/dev/null
echo "[OK]   Created ${BZIP2_ARCHIVE}"

# ---------------------------------------------------------------------------
# G4. Use fileSize() to determine the size of each archive.
# ---------------------------------------------------------------------------
GZIP_SIZE=$(fileSize "${GZIP_ARCHIVE}")
BZIP2_SIZE=$(fileSize "${BZIP2_ARCHIVE}")

echo
echo "============================================================"
echo "Compressed archive sizes (via fileSize)"
echo "------------------------------------------------------------"
printf '  gzip  : %12d bytes  (%s)\n' "${GZIP_SIZE}"  "$(humanSize "${GZIP_SIZE}")"
printf '  bzip2 : %12d bytes  (%s)\n' "${BZIP2_SIZE}" "$(humanSize "${BZIP2_SIZE}")"

# ---------------------------------------------------------------------------
# G5. Display the difference.
# ---------------------------------------------------------------------------
DIFF=$(( GZIP_SIZE - BZIP2_SIZE ))
ABS_DIFF=${DIFF#-}

echo
echo "============================================================"
echo "Difference between the two compression algorithms"
echo "------------------------------------------------------------"
if (( DIFF > 0 )); then
    printf '  bzip2 was smaller than gzip by %d bytes (%s).\n' \
        "${ABS_DIFF}" "$(humanSize "${ABS_DIFF}")"
elif (( DIFF < 0 )); then
    printf '  gzip was smaller than bzip2 by %d bytes (%s).\n' \
        "${ABS_DIFF}" "$(humanSize "${ABS_DIFF}")"
else
    echo "  Both archives are exactly the same size."
fi
echo "============================================================"

exit 0
