# Part C — Recording Script

**Goal of this video:**
1. Show the new `$` prompt with two distinct colors (prompt vs. shell text). [C1]
2. Show the separate aliases file and run each alias. [C2, C3]
3. Create `/root/bin`, move `create_user.sh` and `delete_user.sh` into it,
   update `~/.bashrc` so the bin directory is on PATH, and run both scripts
   from a directory other than bin. [C4a, C4b, C4c]

Estimated length: **3–4 minutes**.

> ⚠️ This part is the most setup-heavy. Do **all** of section 0 below BEFORE
> hitting record. The video itself only needs the commands in sections 🔴 1.

---

## 0. Setup BEFORE you hit record

For convenience the assignment specifies "the root directory" — meaning the
home directory of the root user, `/root`. All commands below are run as root
(easiest in the Multipass VM via `sudo -i`).

```bash
sudo -i                 # become root for the whole demo
cd ~/D796/C_shell_config

# 1) Install the aliases file
cp bash_aliases /root/.bash_aliases

# 2) Append the prompt + PATH + sourcing block to /root/.bashrc, but only once
grep -q 'WGU D796 — RQN1 Task 1, Part C' /root/.bashrc \
    || cat bashrc_additions.sh >> /root/.bashrc

# 3) Make sure the demo target directories exist (for the alias demo)
mkdir -p /root/Desktop /root/Downloads /root/Documents

# 4) Pre-create /root/bin and move the two scripts into it
mkdir -p /root/bin
cp ../A_create_user/create_user.sh /root/bin/
cp ../B_delete_user/delete_user.sh /root/bin/
chmod +x /root/bin/create_user.sh /root/bin/delete_user.sh

# 5) Make sure devuser does not exist
userdel -r devuser 2>/dev/null || true
groupdel dev_group 2>/dev/null || true

clear
```

Stay in the root shell. You're ready to record.

---

## 🔴 1. START RECORDING

### Narration line 1
> "This is Part C — shell configuration. I'll source the new `~/.bashrc`, show the colored `$` prompt, demo the aliases, then run my two scripts from a non-bin directory."

### Demo command 1 — show the bashrc additions and the aliases file
```bash
cat ~/.bash_aliases
echo "------"
tail -30 ~/.bashrc
```

### Demo command 2 — C3: apply the changes from the command line and verify
```bash
source ~/.bashrc
```

The prompt should immediately change to a green `$` and anything you type
should appear in cyan. Pause for a beat so the camera catches the new prompt.

### Narration line 2
> "Prompt is now `$` in green; my shell text is cyan — two different colors as required."

### Demo command 3 — C2 + C3: demonstrate each alias
```bash
ll          # alias for ls -lrt
la          # alias for ls -a
c           # alias for clear (the screen will clear)
desktop     # navigates to /root/Desktop
pwd
download    # navigates to /root/Downloads
pwd
documents   # navigates to /root/Documents
pwd
cd ~        # back to /root
```

### Narration line 3
> "All four aliases work — `ll`, `la`, `c`, and the three navigation aliases. Now I'll show the bin directory, the PATH update, and run my scripts from somewhere else."

### Demo command 4 — C4a: show /root/bin contains both scripts
```bash
ls -l /root/bin
```
**Expected output:** both `create_user.sh` and `delete_user.sh` are listed and executable.

### Demo command 5 — C4b: prove /root/bin is on PATH
```bash
echo "$PATH"
which create_user.sh
which delete_user.sh
```
Both `which` calls should print `/root/bin/create_user.sh` and
`/root/bin/delete_user.sh`.

### Demo command 6 — C4c: run BOTH scripts from a directory other than bin
```bash
cd /tmp
pwd                      # confirms we are NOT in /root/bin

create_user.sh devuser   # runs from /tmp because PATH includes /root/bin
echo "---- delete now ----"
echo yes | delete_user.sh devuser
```

### Narration line 4
> "Both scripts ran from `/tmp` without specifying a path — proving the PATH update works. End of Part C."

---

## 🛑 2. STOP RECORDING

Save and upload to Panopto.

---

## Rubric coverage for this video

| Rubric | Where it's shown |
|---|---|
| C1 — `$` prompt + two distinct colors | Demo command 2 (after `source`) |
| C2 — aliases file with required commands and nav aliases | Demo commands 1 and 3 |
| C3 — changes applied from command line and verified | Demo commands 2 and 3 |
| C4a — bin directory created with both scripts | Demo command 4 |
| C4b — PATH updated so both scripts run from anywhere | Demo command 5 |
| C4c — execution from a non-bin directory | Demo command 6 (`cd /tmp` then run both) |
