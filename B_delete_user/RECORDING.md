# Part B — `delete_user.sh` — Recording Teleprompter

> 📌 **How to use this file:** Read every 🎙️ **SAY** block out loud, word for word.
> When you see ⌨️ **TYPE**, run that command in the terminal and wait for it to finish.
> Then continue reading. Don't skip, don't improvise — just go top to bottom.

---

## ⚠️ Setup — DO this BEFORE you press Record

```bash
cd ~/d796/B_delete_user
chmod +x delete_user.sh

# Recreate devuser so we have something to delete on camera
sudo ../A_create_user/create_user.sh devuser >/dev/null 2>&1 || true
id devuser   # confirms the user exists

clear
```

Open Panopto, turn on your webcam, capture the full screen, and hit Record.

---

## 🔴 RECORDING STARTS HERE

### 🎙️ SAY
> "Hello, my name is Tonio Jenkins. This is Part B of the WGU D796 RQN1 task. I will be demonstrating the `delete_user.sh` script. First I will walk through the code, and then I will run the script and explain the output."

### ⌨️ TYPE
```bash
cat delete_user.sh
```

### 🎙️ SAY
> "At the top of the script, the shebang line tells the system to run this with bash. The `set -euo pipefail` line makes the script stop immediately if anything goes wrong, which is a safety net for automation."

### 🎙️ SAY
> "The first block of logic checks that I passed in a username. If I did not, the script prints an error message to standard error and exits with code one. This satisfies rubric item B1, which requires the script to verify that an argument was provided."

### 🎙️ SAY
> "The next block confirms the script is being run as root, because deleting a user requires root privileges. After that, I do a preflight check using the `id` command to make sure the user actually exists before going any further."

### 🎙️ SAY
> "The block under `B2` is the confirmation prompt. I use `read -r -p` to ask the operator to type yes or no. The `case` statement makes the response case-insensitive. Anything other than yes or y will cancel the deletion. This satisfies rubric item B2, which requires the script to ask for confirmation before deleting."

### 🎙️ SAY
> "The deletion block first uses `pkill` to terminate any active processes owned by the user, because `userdel` will refuse to delete a user with active processes. Then I run `userdel -r`, which removes both the user account and the home directory in a single command. If `userdel -r` fails, I have a fallback that uses a plain `userdel` followed by `rm -rf` on the home directory. This satisfies rubric item B3."

### 🎙️ SAY
> "The verification block uses `grep` to search `/etc/passwd` for the username. If grep finds nothing, I print a confirmation that the user is gone. I also use `tail` to display the last five lines of `/etc/passwd` so the file's contents are visible on screen. This satisfies rubric item B4, which requires the script to display `/etc/passwd` for verification."

### 🎙️ SAY
> "Now I will demonstrate the script. First, I will run it with no arguments to show that the validation works."

### ⌨️ TYPE
```bash
sudo ./delete_user.sh
```

### 🎙️ SAY
> "As you can see, the script printed `ERROR: No username supplied` and gave me the correct usage. This is the first bullet of rubric item B5 — running the script without arguments produces the expected error."

### 🎙️ SAY
> "Now I will run it with a valid username. I will type yes when it asks for confirmation."

### ⌨️ TYPE
```bash
sudo ./delete_user.sh devuser
```

> *(when prompted, type **`yes`** and press Enter)*

### 🎙️ SAY
> "The script asked for confirmation, which is rubric item B2. I typed yes, and it proceeded with the deletion. The output shows that the user was removed, the home directory was deleted, and the user is no longer in `/etc/passwd`. The tail of `/etc/passwd` confirms devuser is no longer there. This is the second bullet of rubric item B5 — running with valid arguments — and also satisfies B3 and B4."

### 🎙️ SAY
> "For final verification, I will try to switch to the deleted user."

### ⌨️ TYPE
```bash
su - devuser
```

### 🎙️ SAY
> "The system rejected the switch because devuser does not exist. This is the third bullet of rubric item B5 — confirming that the deletion has occurred. This completes Part B. The script verified the argument, asked for confirmation, deleted the user and home directory, displayed `/etc/passwd`, and proved the user is gone. Rubric items B1 through B5 are all satisfied. Thank you."

## 🛑 STOP RECORDING

---

## Rubric coverage

| Rubric | Where in the video |
|---|---|
| B — script named correctly | The `cat` command |
| B1 — argument verification | The "no arguments" run |
| B2 — confirmation prompt | The "yes/no" prompt |
| B3 — deletes user + home dir | The `[OK] User 'devuser' removed` line |
| B4 — `/etc/passwd` displayed | The grep + tail block |
| B5 — full demo (no args / with args / `su` rejected) | All three runs |
