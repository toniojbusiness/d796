# Part A — Recording Script

**Goal of this video:** demonstrate that `create_user.sh` (1) errors when no
argument is given, (2) creates the `dev_group` and a new user with a password,
(3) prints `/etc/passwd` for verification, and (4) lets you `su` to the new
user with the password being forced to change on first login.

Estimated length: **2–3 minutes**.

---

## 0. Setup BEFORE you hit record

```bash
# In the Multipass VM
cd ~/D796/A_create_user
chmod +x create_user.sh

# Make absolutely sure devuser does NOT exist yet (silent if it doesn't)
sudo userdel -r devuser 2>/dev/null || true
sudo groupdel dev_group 2>/dev/null || true

clear
```

---

## 🔴 1. START RECORDING

Open Panopto, ensure webcam + screen are both being captured, hit Record.

### Narration line 1
> "This is Part A — `create_user.sh`. I'll demonstrate the error path, then create a user, then switch to it."

### Demo command 1 — show the script
```bash
cat create_user.sh
```

### Narration line 2
> "Now I'll run it with **no arguments** to show the validation error."

### Demo command 2 — A5 bullet 1: run without arguments
```bash
sudo ./create_user.sh
```
**Expected output:**
```
ERROR: No username supplied.
Usage: sudo ./create_user.sh <username>
```

### Narration line 3
> "Good — exit code is non-zero. Now I'll run it with a valid argument."

### Demo command 3 — A5 bullet 2: run with valid argument
```bash
sudo ./create_user.sh devuser
```
**Expected output (key lines):**
```
[INFO] Creating group 'dev_group'...
[OK]   Group 'dev_group' created.
[INFO] Creating user 'devuser' with home directory and bash shell...
[OK]   User 'devuser' created and added to 'dev_group'.
[OK]   Default password assigned: ChangeMe123!
[OK]   Password expired — 'devuser' will be forced to change it on first login.
devuser:x:1001:1002::/home/devuser:/bin/bash
...
```

### Demo command 4 — extra evidence for the rubric
```bash
getent group dev_group
grep devuser /etc/passwd
```

### Narration line 4
> "The user is in `/etc/passwd` and is a member of `dev_group`. Now I'll switch to the user — the password change will be forced."

### Demo command 5 — A5 bullet 3: switch to the new user and force password change
```bash
su - devuser
```
When prompted:
- **Password:** `ChangeMe123!`
- **Current password:** `ChangeMe123!`
- **New password:** `NewPass456!`  (or anything that meets policy)
- **Retype new password:** `NewPass456!`

You should land in `devuser`'s shell. Confirm:
```bash
whoami
pwd
exit
```

### Narration line 5
> "User created, password assigned, and forced password change confirmed. End of Part A."

---

## 🛑 2. STOP RECORDING

Save and upload to Panopto. Copy the share URL — you'll paste it in the WGU Links section.

---

## Rubric coverage for this video

| Rubric | Where it's shown |
|---|---|
| A — script named `create_user.sh` | filename in `cat` and `./create_user.sh` |
| A1 — username arg + error message | Demo command 2 |
| A2 — `dev_group` created | Demo command 3 output line "Group 'dev_group' created." |
| A3 — user added + password assigned | Demo command 3 |
| A4 — `/etc/passwd` displayed | Demo commands 3 + 4 (`grep`, `tail`) |
| A5 — executable demo: no args / with args / `su` + force pw change | Demo commands 2, 3, and 5 |

---

## Cleanup AFTER recording (optional, lets you re-record cleanly)

```bash
sudo userdel -r devuser
sudo groupdel dev_group
```
