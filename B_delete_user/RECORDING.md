# Part B — `delete_user.sh`

## 📋 Teacher's 4-step flow
1. **Prepare an error-free script first.**
2. **Start recording.**
3. **Explain the code, then explain the output.**
4. **Stop recording.**

> 🎯 Goal: ~5-minute video showing your face + the screen, narrating the deletion script's logic, then the output that proves rubric items B1–B5.

---

## ⚠️ DO BEFORE you press Record

`devuser` must exist first — otherwise there's nothing to delete.

```bash
cd ~/d796/B_delete_user
chmod +x delete_user.sh

# Recreate the user from Part A (silent)
sudo ../A_create_user/create_user.sh devuser >/dev/null 2>&1 || true
id devuser   # confirm the user exists

clear
```

---

## 🔴 START RECORDING

### Intro
> "Hi, I'm Tonio Jenkins. This is Part B — `delete_user.sh`. I'll walk through the code, then run it, then explain the output as it comes back."

---

### 📖 Step 1 — Show & explain the code

```bash
cat delete_user.sh
```

**Talking points (one short paragraph each):**

1. **"Same defensive header — `set -euo pipefail` aborts on any error or unset variable."**

2. **"Rubric **B1** — `if [[ $# -lt 1 || -z "${1:-}" ]]` checks that a username was passed; if not it prints `ERROR: No username supplied.` to standard error and exits with code 1."**

3. **"I also do a preflight `id` check. If the user we were asked to delete doesn't actually exist, we exit with a clear message instead of a confusing `userdel` failure."**

4. **"Rubric **B2** — `read -r -p` prompts the operator for a `yes` or `no`. The `case ${CONFIRM,,}` makes it case-insensitive. Anything other than `yes` or `y` cancels with exit code 4. Confirmation is **mandatory** before we touch anything."**

5. **"Rubric **B3** — first I `pkill -KILL -u` to terminate any active processes owned by the user, otherwise `userdel` would refuse to remove a logged-in user. Then `userdel -r` removes both the account **and** the home directory in one step. If `userdel -r` fails — for example if the mail spool is missing — I fall back to a plain `userdel` plus `rm -rf /home/<user>`."**

6. **"Rubric **B4** — verification. I `grep` the username out of `/etc/passwd`; if no match is found I print a confirmation. I also `tail -5 /etc/passwd` so the file's contents are on screen, and I check that the home directory was actually removed."**

---

### 📺 Step 2 — Run the script & explain the output

#### B5 bullet 1 — run with **no arguments**
```bash
sudo ./delete_user.sh
```
**Expected output:**
```
ERROR: No username supplied.
Usage: sudo ./delete_user.sh <username>
```

> *"That validates rubric B1 — argument required, error printed."*

#### B5 bullet 2 — valid argument, full deletion path
```bash
sudo ./delete_user.sh devuser
```

When prompted: type **`yes`** + Enter.

**Walk through the output:**

> *"`About to permanently delete user 'devuser' AND their home directory.` — that's the rubric B2 confirmation prompt."*
> *"After I type `yes`: `[INFO] Confirmation received. Proceeding with deletion...`"*
> *"`[INFO] Removing user 'devuser' and home directory...` followed by `[OK] User 'devuser' removed.` — that's `userdel -r` in action, satisfying rubric B3."*
> *"`[OK] 'devuser' is no longer in /etc/passwd.` — rubric B4 confirmed by grep."*
> *"The `tail -5 /etc/passwd` shows the new tail of the file — devuser is no longer there."*
> *"`[OK] /home/devuser has been removed.` — home directory deletion verified."*

#### Extra evidence
```bash
grep devuser /etc/passwd || echo "devuser is gone from /etc/passwd"
ls /home
```

> *"`grep` returns nothing, so we print our `gone` fallback. `ls /home` no longer lists devuser."*

#### B5 bullet 3 — try to switch to the deleted user
> "Final proof: try to switch to the user. It must fail."
```bash
su - devuser
```

**Expected output:**
```
su: user devuser does not exist or the user entry does not contain all the required fields
```

> *"Rubric B5 bullet 3 satisfied — switching to a deleted user is impossible."*

---

### Closing line
> "Part B is complete. The script validates the argument, prompts for confirmation, deletes the user and the home directory, displays `/etc/passwd`, and proves the user can no longer be switched to. B1 through B5 covered."

## 🛑 STOP RECORDING

---

## 💬 If you misspeak
Restart from one of:
- Top (`cat delete_user.sh`)
- "Now with no arguments..." (`sudo ./delete_user.sh`)
- "Now with a valid argument..." (`sudo ./delete_user.sh devuser`)
- "Final proof..." (`su - devuser`)

---

## Rubric coverage

| Rubric | Where in the video |
|---|---|
| B — script named `delete_user.sh` | `cat` step |
| B1 — argument verification + error | "no arguments" demo |
| B2 — confirmation prompt | "yes/no" prompt during deletion |
| B3 — deletes user + home dir | `[OK] User 'devuser' removed.` line |
| B4 — `/etc/passwd` displayed | grep + tail block in output |
| B5 — no args / with args / `su` rejected | three demo blocks |
