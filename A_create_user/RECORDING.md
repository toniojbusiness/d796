# Part A — `create_user.sh`

## 📋 Teacher's 4-step flow
1. **Prepare an error-free script first** (already done — script is in this folder).
2. **Start recording** (Panopto, webcam + screen).
3. **Explain the code, then explain the output** (this guide gives you both).
4. **Stop recording.**

> 🎯 Goal: one ~5-minute video that shows the **code AND your face**, narrates each block of the script, runs it, and narrates the output, while satisfying every A1–A5 rubric item.

---

## ⚠️ DO BEFORE you press Record

```bash
cd ~/d796/A_create_user
chmod +x create_user.sh

# Make absolutely sure devuser does NOT exist yet
sudo userdel -r devuser 2>/dev/null || true
sudo groupdel dev_group 2>/dev/null || true

clear
```

Open `create_user.sh` in your editor (or have `cat` ready) so the code is visible during the recording.

---

## 🔴 START RECORDING

### Intro line
> "Hi, I'm Tonio Jenkins. This is Part A of the WGU D796 RQN1 task — `create_user.sh`. I'll walk through the code, then run it, then explain what each part of the output proves."

---

### 📖 Step 1 — Show & explain the code

Run:
```bash
cat create_user.sh
```

While the file is on screen, **say each of these talking points** (one short paragraph each):

1. **"At the top I have `#!/usr/bin/env bash` and `set -euo pipefail`. The shebang tells the OS to use bash; the `set` flags make the script exit on any error, on any unset variable, or on a failed pipe — that's defensive scripting."**

2. **"I declare two `readonly` constants: `DEV_GROUP="dev_group"` and `DEFAULT_PASSWORD="ChangeMe123!"`. `readonly` means they can't be accidentally modified later in the script."**

3. **"This `if [[ $# -lt 1 || -z "${1:-}" ]]` block satisfies rubric **A1** — username argument verification. If the user runs the script with no argument, it prints an error to standard error and exits with code 1."**

4. **"Next I check for root and refuse to overwrite an existing user. Both produce clear error messages."**

5. **"For rubric **A2** — group creation — I use `getent group dev_group`. If the group already exists, I skip creation. Otherwise I run `groupadd dev_group`. This makes the script idempotent — safe to run twice."**

6. **"For rubric **A3** — adding the user — `useradd -m -s /bin/bash -G dev_group` creates the home directory with `-m`, sets bash as the login shell with `-s`, and adds the user to `dev_group` with `-G`. Then `echo username:password | chpasswd` sets the default password non-interactively."**

7. **"`chage -d 0` is critical — it expires the password effective immediately, so the next time the user logs in they're **forced** to change it. That handles the third bullet of rubric **A5**."**

8. **"Finally, for rubric **A4** I `grep` the user's entry from `/etc/passwd`, run `id` to show group membership, and `tail` the last five lines of `/etc/passwd` so you can see the new entry in context."**

---

### 📺 Step 2 — Run the script & explain the output

#### A5 bullet 1 — run with **no arguments**
> "First I'll run it with no arguments to demonstrate the validation."
```bash
sudo ./create_user.sh
```

**Expected output:**
```
ERROR: No username supplied.
Usage: sudo ./create_user.sh <username>
```

> "Exactly as expected — A1 satisfied. Now with a real username."

#### A5 bullet 2 — run with valid argument
```bash
sudo ./create_user.sh devuser
```

**Walk through the output as it appears, line by line:**

> *"`[OK] Group 'dev_group' created.` — that's rubric **A2**."*
> *"`[OK] User 'devuser' created and added to 'dev_group'.` — rubric **A3** part 1."*
> *"`[OK] Default password assigned: ChangeMe123!` — rubric **A3** part 2."*
> *"`[OK] Password expired — devuser will be forced to change it on first login` — that sets up A5 bullet 3."*
> *"In the verification block, this line — `devuser:x:1001:1002::/home/devuser:/bin/bash` — proves the user is now in `/etc/passwd`. That's rubric **A4**."*
> *"And `id devuser` shows group membership including `dev_group`."*

#### Extra evidence
```bash
getent group dev_group
grep devuser /etc/passwd
```

> *"Two final confirmations: the group exists, and the user is in `/etc/passwd`."*

#### A5 bullet 3 — switch to the new user (forced password change)
> "Now I'll switch to the new user. Because of `chage -d 0`, my first action will be a forced password change."

```bash
su - devuser
```

When prompted:
- **Password:** `ChangeMe123!`
- **Current password:** `ChangeMe123!`
- **New password:** `NewPass456!`
- **Retype:** `NewPass456!`

After landing in devuser's shell:
```bash
whoami
pwd
exit
```

> *"`whoami` prints `devuser`, `pwd` shows `/home/devuser` — login succeeded after the forced password change. A5 fully satisfied."*

---

### Closing line
> "That covers Part A. The script is named correctly, validates the argument, creates `dev_group`, creates the user with a default password, displays `/etc/passwd`, and demonstrates the forced password change on first login — rubric items A1 through A5."

## 🛑 STOP RECORDING

---

## 💬 If you misspeak

Restart from any of these natural breakpoints:
- Top of the recording (`cat create_user.sh`)
- "Now I'll run it with no arguments..." (`sudo ./create_user.sh`)
- "Now with a real username..." (`sudo ./create_user.sh devuser`)
- "Now I'll switch to the new user..." (`su - devuser`)

You only need to re-record from the breakpoint forward.

---

## Cleanup AFTER recording (optional)
```bash
sudo userdel -r devuser
sudo groupdel dev_group
```

## Rubric coverage summary

| Rubric | Where in the video |
|---|---|
| A — script named `create_user.sh` | `cat` step + `./create_user.sh` invocation |
| A1 — username arg + error | "no arguments" demo |
| A2 — `dev_group` created | "Group 'dev_group' created" output line |
| A3 — user added + password | "User created" + "Default password assigned" lines |
| A4 — `/etc/passwd` displayed | grep + tail in verification block |
| A5 — executable demo (no args / with args / forced pw change) | three demo blocks above |
