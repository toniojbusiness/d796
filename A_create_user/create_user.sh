#!/usr/bin/env bash
#
# create_user.sh
# WGU D796 — RQN1 Task 1, Part A
# Author: Tonio Jenkins
#
# Purpose:
#   Create a new local user, ensure the "dev_group" group exists, assign a
#   default password, force the user to change the password on first login,
#   and verify the creation by displaying the relevant /etc/passwd entry.
#
# Usage:
#   sudo ./create_user.sh <username>
#
# Exit codes:
#   0  success
#   1  no username argument provided
#   2  must be run as root
#   3  user already exists
#   4  useradd failed
#   5  password assignment failed

set -euo pipefail

readonly DEV_GROUP="dev_group"
readonly DEFAULT_PASSWORD="ChangeMe123!"

# ---------------------------------------------------------------------------
# A1. Verify the username argument was provided.
# ---------------------------------------------------------------------------
if [[ $# -lt 1 || -z "${1:-}" ]]; then
    echo "ERROR: No username supplied." >&2
    echo "Usage: sudo $0 <username>" >&2
    exit 1
fi

readonly USERNAME="$1"

# Must be root to create users / groups.
if [[ "$(id -u)" -ne 0 ]]; then
    echo "ERROR: This script must be run as root (use sudo)." >&2
    exit 2
fi

# Refuse to clobber an existing account.
if id "${USERNAME}" &>/dev/null; then
    echo "ERROR: User '${USERNAME}' already exists." >&2
    exit 3
fi

# ---------------------------------------------------------------------------
# A2. If the group "dev_group" does not exist, create it.
# ---------------------------------------------------------------------------
if getent group "${DEV_GROUP}" >/dev/null; then
    echo "[INFO] Group '${DEV_GROUP}' already exists. Skipping group creation."
else
    echo "[INFO] Creating group '${DEV_GROUP}'..."
    groupadd "${DEV_GROUP}"
    echo "[OK]   Group '${DEV_GROUP}' created."
fi

# ---------------------------------------------------------------------------
# A3. Add the user and assign the default password.
# ---------------------------------------------------------------------------
echo "[INFO] Creating user '${USERNAME}' with home directory and bash shell..."
if ! useradd -m -s /bin/bash -G "${DEV_GROUP}" "${USERNAME}"; then
    echo "ERROR: Failed to create user '${USERNAME}'." >&2
    exit 4
fi
echo "[OK]   User '${USERNAME}' created and added to '${DEV_GROUP}'."

echo "[INFO] Assigning default password..."
if ! echo "${USERNAME}:${DEFAULT_PASSWORD}" | chpasswd; then
    echo "ERROR: Failed to set password for '${USERNAME}'." >&2
    exit 5
fi
echo "[OK]   Default password assigned: ${DEFAULT_PASSWORD}"

# Force the user to change the password on first login.
# This satisfies the rubric requirement to "force a change of password".
chage -d 0 "${USERNAME}"
echo "[OK]   Password expired — '${USERNAME}' will be forced to change it on first login."

# ---------------------------------------------------------------------------
# A4. Display the /etc/passwd file to verify the user was created.
# ---------------------------------------------------------------------------
echo
echo "------------------------------------------------------------"
echo "Verification: relevant /etc/passwd entry"
echo "------------------------------------------------------------"
grep "^${USERNAME}:" /etc/passwd || true

echo
echo "------------------------------------------------------------"
echo "Verification: group membership"
echo "------------------------------------------------------------"
id "${USERNAME}"

echo
echo "------------------------------------------------------------"
echo "Tail of /etc/passwd (last 5 lines)"
echo "------------------------------------------------------------"
tail -n 5 /etc/passwd

echo
echo "[DONE] User '${USERNAME}' created successfully."
echo "       To switch to this user and force the password change run:"
echo "         su - ${USERNAME}"
exit 0
