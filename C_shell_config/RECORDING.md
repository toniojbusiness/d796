# Part C — Shell Configuration

## 📋 Teacher's 4-step flow
1. **Prepare an error-free script first.**
2. **Start recording.**
3. **Explain the code, then explain the output.**
4. **Stop recording.**

> 🎯 Goal: ~5-minute video that shows the bash files **and** the live results: green `$` prompt, working aliases, working PATH for the bin scripts.

---

## ⚠️ DO BEFORE you press Record

This is the most setup-heavy part. Run **everything** in this section before you start recording so the video is clean.

```bash
sudo -i                                  # become root for the whole demo
cd ~/d796/C_shell_config

# 1) Install the aliases file at the spot ~/.bashrc expects
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

# 5) Make sure devuser does not exist
userdel -r devuser 2>/dev/null || true
groupdel dev_group 2>/dev/null || true

clear
```

You're still in a root shell with the OLD prompt. That's intentional — the recording will show the prompt change happen live.

---

## 🔴 START RECORDING

### Intro
> "Hi, I'm Tonio Jenkins. This is Part C — shell configuration. I'll walk through the two configuration files, then source them, then run the aliases and the bin scripts to verify."

---

### 📖 Step 1 — Show & explain the code

#### File 1: the aliases file

```bash
cat ~/.bash_aliases
```

**Talking points:**

1. **"Rubric **C2** asks for shortcuts in a separate aliases file. I keep them in `~/.bash_aliases`. The `alias` keyword binds short names to longer commands."**

2. **"Top three: `ll` is `ls -lrt` (long listing, oldest first), `la` is `ls -a` (show hidden files), `c` is `clear`."**

3. **"Bottom three are navigation aliases — `desktop`, `download`, `documents` — each does `cd "$HOME/<dir>"`. Because `$HOME` is expanded at use-time, these work for any user that sources the file."**

#### File 2: the bashrc snippet

```bash
cat ~/d796/C_shell_config/bashrc_additions.sh
```

**Talking points:**

4. **"Rubric **C1** — `export PS1='\[\e[1;32m\]$\[\e[1;36m\] '`. `\e[1;32m` is the ANSI escape for bright green; the prompt symbol `$` will render in green. `\e[1;36m` is bright cyan, applied right after the `$` so anything I type into the shell is cyan. The prompt color and the shell-text color are deliberately different."**

5. **"The `\[ \]` wrappers around the escape sequences tell bash not to count those bytes when measuring prompt width — that prevents line-wrap glitches."**

6. **"The `trap 'printf "\e[0m"' DEBUG` line resets the color before each command runs so command **output** still appears in the default terminal color — keeps things readable."**

7. **"Rubric **C2** integration — the `if [ -f "$HOME/.bash_aliases" ]; then . "$HOME/.bash_aliases"; fi` block sources the aliases file we just looked at."**

8. **"Rubric **C4b** — `if [ -d "$HOME/bin" ] ; then PATH="$HOME/bin:$PATH"; fi` and `export PATH`. This adds the bin directory to the front of `PATH`, so any executable inside `~/bin` can be called by name from any directory."**

---

### 📺 Step 2 — Apply and explain the output

#### Step 2a — Apply the changes (rubric C3)

```bash
source ~/.bashrc
```

> *"The prompt just changed. The dollar sign is green, and as soon as I start typing, my text shows up in cyan — two distinct colors. Rubric C1 satisfied."*

> *"That `source` command is rubric C3 — applying the changes from the command line."*

#### Step 2b — Demo the aliases (rubric C2 + C3)

```bash
ll
```
> *"`ll` ran `ls -lrt`. You can see the long listing sorted by modification time."*

```bash
la
```
> *"`la` ran `ls -a` — including the hidden dotfiles."*

```bash
c
```
> *"`c` cleared the screen — the third command alias works."*

```bash
desktop
pwd
```
> *"`desktop` jumped to `/root/Desktop` — confirmed by `pwd`."*

```bash
download
pwd
documents
pwd
cd ~
```
> *"`download` and `documents` work the same way. All six aliases verified — rubric C2 fully satisfied, and these were applied live from the command line so C3 is also covered."*

#### Step 2c — Verify the bin directory and PATH (rubric C4)

```bash
ls -l /root/bin
```
> *"Rubric **C4a** — `/root/bin` exists and contains both `create_user.sh` and `delete_user.sh`, executable."*

```bash
echo "$PATH"
which create_user.sh
which delete_user.sh
```
> *"Rubric **C4b** — `/root/bin` is on PATH. `which` resolves both scripts to `/root/bin/<name>`."*

#### Step 2d — Run BOTH scripts from a non-bin directory (rubric C4c)

```bash
cd /tmp
pwd
create_user.sh devuser
echo "---- now delete ----"
echo yes | delete_user.sh devuser
```

> *"I'm in `/tmp`, NOT in `/root/bin`. `create_user.sh` ran by name and successfully created the user — output shows the dev_group creation, the user creation, the password assignment. Then I piped `yes` into `delete_user.sh` to non-interactively confirm the deletion. Both scripts ran from a directory other than bin, satisfying rubric **C4c**."*

---

### Closing
> "Part C complete. The prompt is `$` with green-on-cyan coloring, the aliases file works, the bin directory is on PATH, and both scripts run from `/tmp` — every C1 through C4c rubric item covered."

## 🛑 STOP RECORDING

---

## 💬 If you misspeak

Restart from any of:
- Top (`cat ~/.bash_aliases`)
- "Now I'll apply the changes..." (`source ~/.bashrc`)
- Aliases demo (`ll`)
- "Now I'll verify the bin directory..." (`ls -l /root/bin`)
- "Now from a non-bin directory..." (`cd /tmp`)

---

## Rubric coverage

| Rubric | Where |
|---|---|
| C1 — `$` prompt + two colors | `source ~/.bashrc` moment |
| C2 — aliases file | `cat ~/.bash_aliases` + each alias demo |
| C3 — applied from command line + verified | `source` + alias demo |
| C4a — `/root/bin` with both scripts | `ls -l /root/bin` |
| C4b — PATH includes bin | `which` outputs |
| C4c — run from non-bin directory | `cd /tmp` then run |
