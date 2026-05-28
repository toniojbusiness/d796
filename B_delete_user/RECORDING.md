# Part B — Recording Script

**Goal of this video:** demonstrate that `delete_user.sh` (1) errors when no
argument is given, (2) asks for confirmation, (3) removes the user and home
directory, (4) shows `/etc/passwd` proving the user is gone, and (5) confirms
that `su - devuser` no longer works.

Estimated length: **2–3 minutes**.

---

## 0. Setup BEFORE you hit record

The user `devuser` must exist (created in Part A). If you cleaned up after
Part A, recreate them quickly:

```bash
cd ~/D796/B_delete_user
chmod +x delete_user.sh

# Make sure the user exists so we have something to delete on camera
sudo ../A_create_user/create_user.sh devuser 2>/dev/null || true
id devuser   # should print uid/gid info — confirms the user exists

clear
```

---

## 🔴 1. START RECORDING

### Narration line 1
> "This is Part B — `delete_user.sh`. I'll show the error path, then delete the user we created in Part A, then prove they cannot log in any more."

### Demo command 1 — show the script
```bash
cat delete_user.sh
```

### Narration line 2
> "First, run with **no arguments** — should produce a clear error."

### Demo command 2 — B5 bullet 1: run without arguments
```bash
sudo ./delete_user.sh
```
**Expected output:**
```
ERROR: No username supplied.
Usage: sudo ./delete_user.sh <username>
```

### Narration line 3
> "Now I'll run it with a valid argument. The script will ask me to confirm before it does anything destructive."

### Demo command 3 — B5 bullet 2: run with valid argument and confirm
```bash
sudo ./delete_user.sh devuser
```
When prompted:
- **Are you sure you want to continue? (yes/no):** type `yes` and press Enter.

**Expected output (key lines):**
```
About to permanently delete user 'devuser' AND their home directory.
Are you sure you want to continue? (yes/no): yes
[INFO] Confirmation received. Proceeding with deletion...
[INFO] Removing user 'devuser' and home directory...
[OK]   User 'devuser' removed.
[OK]   'devuser' is no longer in /etc/passwd.
[OK]   /home/devuser has been removed.
[DONE] User 'devuser' deletion complete.
```

### Narration line 4
> "User removed. Let's verify with another grep against `/etc/passwd` and try to switch to the user — it should fail."

### Demo command 4 — extra evidence
```bash
grep devuser /etc/passwd || echo "devuser is gone from /etc/passwd"
ls /home
```

### Demo command 5 — B5 bullet 3: attempt to switch to the deleted user
```bash
su - devuser
```
**Expected output:**
```
su: user devuser does not exist or the user entry does not contain all the required fields
```

### Narration line 5
> "Confirmed — `devuser` is fully deleted, the home directory is gone, and `su` to that user is rejected. End of Part B."

---

## 🛑 2. STOP RECORDING

Upload to Panopto and copy the URL.

---

## Rubric coverage for this video

| Rubric | Where it's shown |
|---|---|
| B — script named `delete_user.sh` | Demo command 1 |
| B1 — argument verification + error | Demo command 2 |
| B2 — confirmation prompt | Demo command 3 (the `yes/no` prompt) |
| B3 — deletes user and home dir | Demo command 3 (`userdel -r`) |
| B4 — `/etc/passwd` displayed | Demo commands 3 and 4 |
| B5 — executable demo: no args / with args / `su` rejected | Demo commands 2, 3, 5 |
