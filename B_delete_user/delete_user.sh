#!/usr/bin/env bash
#
# delete_user.sh
# WGU D796 — RQN1 Task 1, Part B
# Author: Tonio Jenkins
#
# Purpose:
#   Delete a local user (and their home directory) after asking for explicit
#   confirmation. Verify the deletion by displaying the relevant portion of
#   /etc/passwd.
#
# Usage:
#   sudo ./delete_user.sh <username>
#
# Exit codes:
#   0  success
#   1  no username argument supplied
#   2  must be run as root
#   3  user does not exist
#   4  user cancelled the deletion
#   5  userdel failed

set -euo pipefail

# ---------------------------------------------------------------------------
# B1. Verify the username argument was provided.
# ---------------------------------------------------------------------------
if [[ $# -lt 1 || -z "${1:-}" ]]; then
    echo "ERROR: No username supplied." >&2
    echo "Usage: sudo $0 <username>" >&2
    exit 1
fi

readonly USERNAME="$1"

if [[ "$(id -u)" -ne 0 ]]; then
    echo "ERROR: This script must be run as root (use sudo)." >&2
    exit 2
fi

# B3 (preflight). Verify the user actually exists before going further.
if ! id "${USERNAME}" &>/dev/null; then
    echo "ERROR: User '${USERNAME}' does not exist on this system." >&2
    exit 3
fi

# ---------------------------------------------------------------------------
# B2. Ask for confirmation before deleting.
# ---------------------------------------------------------------------------
echo "About to permanently delete user '${USERNAME}' AND their home directory."
read -r -p "Are you sure you want to continue? (yes/no): " CONFIRM

case "${CONFIRM,,}" in
    yes|y)
        echo "[INFO] Confirmation received. Proceeding with deletion..."
        ;;
    *)
        echo "[INFO] Deletion cancelled by user."
        exit 4
        ;;
esac

# ---------------------------------------------------------------------------
# B3. Delete the user and the home directory.
# ---------------------------------------------------------------------------
# Kill any processes owned by this user so userdel does not fail.
if pgrep -u "${USERNAME}" >/dev/null; then
    echo "[INFO] Terminating active processes owned by '${USERNAME}'..."
    pkill -KILL -u "${USERNAME}" || true
    sleep 1
fi

echo "[INFO] Removing user '${USERNAME}' and home directory..."
if ! userdel -r "${USERNAME}" 2>/dev/null; then
    # userdel -r can fail if the mail spool is missing — try without -r and
    # then remove the home directory manually.
    if ! userdel "${USERNAME}"; then
        echo "ERROR: userdel failed for '${USERNAME}'." >&2
        exit 5
    fi
    rm -rf "/home/${USERNAME}" || true
fi
echo "[OK]   User '${USERNAME}' removed."

# ---------------------------------------------------------------------------
# B4. Display /etc/passwd to verify the deletion.
# ---------------------------------------------------------------------------
echo
echo "------------------------------------------------------------"
echo "Verification: searching /etc/passwd for '${USERNAME}'"
echo "------------------------------------------------------------"
if grep -q "^${USERNAME}:" /etc/passwd; then
    echo "WARNING: '${USERNAME}' is still present in /etc/passwd!" >&2
else
    echo "[OK]   '${USERNAME}' is no longer in /etc/passwd."
fi

echo
echo "------------------------------------------------------------"
echo "Tail of /etc/passwd (last 5 lines)"
echo "------------------------------------------------------------"
tail -n 5 /etc/passwd

echo
echo "------------------------------------------------------------"
echo "Verification: home directory presence"
echo "------------------------------------------------------------"
if [[ -d "/home/${USERNAME}" ]]; then
    echo "WARNING: /home/${USERNAME} still exists!" >&2
else
    echo "[OK]   /home/${USERNAME} has been removed."
fi

echo
echo "[DONE] User '${USERNAME}' deletion complete."
exit 0
