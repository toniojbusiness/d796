# Part C — Shell Configuration — Recording Teleprompter (v2 — re-record)

> 📌 **How to use this file:** Read every 🎙️ **SAY** block out loud, word for word.
> When you see ⌨️ **TYPE**, run that command and wait for it to finish.
> Don't skip, don't improvise — just go top to bottom.

> ⚠️ **This is a re-record of Part C.** The evaluator's note: *"The Panopto video
> displayed some of the aliases being executed in the terminal. The Panopto
> video needs to display all of the aliases being executed in the terminal."*
> This version explicitly demos every single alias with on-screen banners
> labeling each one, then prints a final summary so all six are visible at once.

---

## ⚠️ Setup — DO this BEFORE you press Record

Run **everything** here off-camera first.

```bash
sudo -i                                  # become root for the whole demo
cd ~/d796/C_shell_config

# 1) Install the aliases file where ~/.bashrc expects it
cp bash_aliases /root/.bash_aliases

# 2) Append the prompt + sourcing + PATH stanza to /root/.bashrc, but only once
grep -q 'WGU D796 — RQN1 Task 1, Part C' /root/.bashrc \
    || cat bashrc_additions.sh >> /root/.bashrc

# 3) Demo target directories for the navigation aliases (must exist)
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
> "Hello, my name is Tonio Jenkins. This is Part C of the WGU D796 task. In this part I will demonstrate the shell configuration: a custom prompt, six aliases stored in a separate aliases file, and a bin directory added to the PATH so my scripts run from any directory."

### 🎙️ SAY
> "First, let me show you the aliases file."

### ⌨️ TYPE
```bash
cat ~/.bash_aliases
```

### 🎙️ SAY
> "This is the separate aliases file. There are six aliases in total. Three are shortcuts for common commands: `ll` runs `ls -lrt`, `la` runs `ls -a`, and `c` runs `clear`. The other three are navigation aliases that take me to a directory in the root home: `desktop` jumps to `/root/Desktop`, `download` to `/root/Downloads`, and `documents` to `/root/Documents`."

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
> "Now I will demonstrate every single alias one at a time, with a banner before each one so it is clearly visible. I will start with the three command aliases, then the three navigation aliases, and end with the clear alias."

---

#### 🎙️ SAY (alias 1 of 6)
> "First, the `ll` alias — it runs `ls -lrt`."

### ⌨️ TYPE
```bash
echo "===== Alias 1 of 6 — ll (ls -lrt) ====="
ll
```

### 🎙️ SAY
> "The output is a long listing sorted by modification time. Alias one of six is verified."

---

#### 🎙️ SAY (alias 2 of 6)
> "Next, the `la` alias — it runs `ls -a`."

### ⌨️ TYPE
```bash
echo "===== Alias 2 of 6 — la (ls -a) ====="
la
```

### 🎙️ SAY
> "The output shows all files including the hidden dotfiles. Alias two of six is verified."

---

#### 🎙️ SAY (alias 3 of 6)
> "Next, the `desktop` navigation alias — it should take me to the Desktop folder."

### ⌨️ TYPE
```bash
echo "===== Alias 3 of 6 — desktop (cd to ~/Desktop) ====="
desktop
pwd
```

### 🎙️ SAY
> "`pwd` shows I am now in `/root/Desktop`. Alias three of six is verified."

---

#### 🎙️ SAY (alias 4 of 6)
> "Next, the `download` navigation alias — it should take me to the Downloads folder."

### ⌨️ TYPE
```bash
echo "===== Alias 4 of 6 — download (cd to ~/Downloads) ====="
download
pwd
```

### 🎙️ SAY
> "`pwd` shows I am now in `/root/Downloads`. Alias four of six is verified."

---

#### 🎙️ SAY (alias 5 of 6)
> "Next, the `documents` navigation alias — it should take me to the Documents folder."

### ⌨️ TYPE
```bash
echo "===== Alias 5 of 6 — documents (cd to ~/Documents) ====="
documents
pwd
cd ~
```

### 🎙️ SAY
> "`pwd` shows I am now in `/root/Documents`. Alias five of six is verified. I returned to home for the next demo."

---

#### 🎙️ SAY (alias 6 of 6)
> "Finally, the `c` alias — it runs `clear`. I will pause for two seconds before running it so the previous output is on screen, then `c` will clear it."

### ⌨️ TYPE
```bash
echo "===== Alias 6 of 6 — c (clear) — running in 2 seconds... ====="
sleep 2
c
```

### 🎙️ SAY
> "The screen has been cleared. Alias six of six is verified."

---

### 🎙️ SAY
> "For belt-and-suspenders proof, I will list every alias defined in this session."

### ⌨️ TYPE
```bash
echo "===== Final summary — every alias in this session ====="
alias ll la c desktop download documents
```

### 🎙️ SAY
> "All six aliases are listed with their definitions: `ll` equals `ls -lrt`, `la` equals `ls -a`, `c` equals `clear`, and the three navigation aliases each `cd` to their respective directory under root's home."

---

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
| C2 — aliases file | `cat ~/.bash_aliases` plus the six per-alias demo blocks |
| C3 — applied from command line, all six aliases verified | `source` + six labeled per-alias runs + final `alias` summary |
| C4a — bin directory with both scripts | `ls -l /root/bin` |
| C4b — PATH includes bin | `which` outputs |
| C4c — execution from a non-bin directory | The `/tmp` runs at the end |
