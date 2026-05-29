# Part C — Shell Configuration — Recording Teleprompter

> 📌 **How to use this file:** Read every 🎙️ **SAY** block out loud, word for word.
> When you see ⌨️ **TYPE**, run that command and wait for it to finish.
> Don't skip, don't improvise — just go top to bottom.

---

## ⚠️ Setup — DO this BEFORE you press Record

This is the most setup-heavy part. Run **everything** here off-camera first.

```bash
sudo -i                                  # become root for the whole demo
cd ~/d796/C_shell_config

# 1) Install the aliases file where ~/.bashrc expects it
cp bash_aliases /root/.bash_aliases

# 2) Append the prompt + sourcing + PATH stanza to /root/.bashrc, but only once
grep -q 'WGU D796 — RQN1 Task 1, Part C' /root/.bashrc \
    || cat bashrc_additions.sh >> /root/.bashrc

# 3) Demo target directories for the navigation aliases
mkdir -p /root/Desktop /root/Downloads /root/Documents

# 4) Pre-create /root/bin and put both scripts in it
mkdir -p /root/bin
cp ../A_create_user/create_user.sh /root/bin/
cp ../B_delete_user/delete_user.sh /root/bin/
chmod +x /root/bin/create_user.sh /root/bin/delete_user.sh

# 5) Make sure devuser does not exist (so the demo at the end works)
userdel -r devuser 2>/dev/null || true
groupdel dev_group 2>/dev/null || true

clear
```

Stay in the root shell — the prompt change should happen LIVE on camera.

---

## 🔴 RECORDING STARTS HERE

### 🎙️ SAY
> "Hello, my name is Tonio Jenkins. This is Part C of the WGU D796 task. In this part I will demonstrate the shell configuration: a custom prompt, a separate aliases file, and a bin directory added to the PATH so my scripts run from any directory."

### 🎙️ SAY
> "First, let me show you the aliases file."

### ⌨️ TYPE
```bash
cat ~/.bash_aliases
```

### 🎙️ SAY
> "This is the separate aliases file. The first three aliases are shortcuts for common commands: `ll` runs `ls -lrt`, `la` runs `ls -a`, and `c` runs `clear`. The next three are navigation aliases: `desktop` jumps to the Desktop folder, `download` to Downloads, and `documents` to Documents."

### 🎙️ SAY
> "Now let me show you the additions to the bashrc file."

### ⌨️ TYPE
```bash
cat ~/d796/C_shell_config/bashrc_additions.sh
```

### 🎙️ SAY
> "The `export PS1` line changes the prompt to a dollar sign and uses ANSI color escape sequences. The code `\e[1;32m` makes the dollar sign bright green, and `\e[1;36m` makes the shell text bright cyan, so the prompt color and the shell text color are deliberately different."

### 🎙️ SAY
> "Below that, the `if -f .bash_aliases` block sources the aliases file we just looked at. The final block adds `$HOME/bin` to the front of the PATH variable, which makes any script in that directory runnable from anywhere."

### 🎙️ SAY
> "Now I will apply all of these changes from the command line."

### ⌨️ TYPE
```bash
source ~/.bashrc
```

### 🎙️ SAY
> "The prompt has just changed to a green dollar sign, and the text I am about to type will appear in cyan — two distinct colors."

### 🎙️ SAY
> "Now I will demonstrate the aliases."

### ⌨️ TYPE
```bash
ll
```

### 🎙️ SAY
> "The `ll` alias ran `ls -lrt` — a long listing sorted by modification time."

### ⌨️ TYPE
```bash
la
```

### 🎙️ SAY
> "The `la` alias ran `ls -a` and showed the hidden files."

### ⌨️ TYPE
```bash
c
```

### 🎙️ SAY
> "The `c` alias cleared the screen. Three command aliases verified."

### ⌨️ TYPE
```bash
desktop
pwd
```

### 🎙️ SAY
> "The `desktop` alias took me straight to `/root/Desktop`, confirmed by `pwd`."

### ⌨️ TYPE
```bash
download
pwd
```

### 🎙️ SAY
> "The `download` alias took me to `/root/Downloads`."

### ⌨️ TYPE
```bash
documents
pwd
cd ~
```

### 🎙️ SAY
> "And the `documents` alias took me to `/root/Documents`. All six aliases work."

### 🎙️ SAY
> "Now I will show the bin directory and the PATH update."

### ⌨️ TYPE
```bash
ls -l /root/bin
```

### 🎙️ SAY
> "The bin directory exists and contains both `create_user.sh` and `delete_user.sh`, both executable."

### ⌨️ TYPE
```bash
echo "$PATH"
which create_user.sh
which delete_user.sh
```

### 🎙️ SAY
> "The PATH variable includes `/root/bin`, and `which` confirms both scripts are resolved from that location."

### 🎙️ SAY
> "Finally, I will run both scripts from a directory that is NOT bin, to prove the PATH update works."

### ⌨️ TYPE
```bash
cd /tmp
pwd
```

### 🎙️ SAY
> "I am now in `/tmp`, not in `/root/bin`. Watch as I call both scripts by name only."

### ⌨️ TYPE
```bash
create_user.sh devuser
```

### 🎙️ SAY
> "The create_user script ran successfully from `/tmp` — the user was created, the password was assigned. Now the delete script."

### ⌨️ TYPE
```bash
echo yes | delete_user.sh devuser
```

### 🎙️ SAY
> "The delete script also ran from `/tmp`. I piped yes into it to non-interactively confirm the deletion. Both scripts ran from a directory other than bin. This completes Part C. Thank you."

## 🛑 STOP RECORDING

---

## Rubric coverage (for your reference — do NOT mention in the video)

| Rubric | Where |
|---|---|
| C1 — `$` prompt with two colors | After `source ~/.bashrc` |
| C2 — aliases file | `cat ~/.bash_aliases` and each alias demo |
| C3 — applied from command line and verified | `source` + alias demo |
| C4a — bin directory with both scripts | `ls -l /root/bin` |
| C4b — PATH includes bin | `which` outputs |
| C4c — execution from a non-bin directory | The `/tmp` runs at the end |
