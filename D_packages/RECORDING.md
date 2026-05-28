# Part D — Package Management

## 📋 Teacher's 4-step flow
1. **Prepare an error-free script first.**
2. **Start recording.**
3. **Explain the code, then explain the output.**
4. **Stop recording.**

> 🎯 Goal: ~4-minute video covering BOTH `install_vim.sh` and `update_packages.sh`. Code walkthrough + live runs + output explanation.

---

## ⚠️ DO BEFORE you press Record

```bash
sudo -i
cd ~/d796/D_packages
chmod +x install_vim.sh update_packages.sh

# Remove any stale log
rm -f update.log

# Optional: uninstall vim so you can demo BOTH branches of install_vim.sh
apt-get remove -y vim vim-runtime vim-common vim-tiny 2>/dev/null || true

clear
```

---

## 🔴 START RECORDING

### Intro
> "Part D — package management. Two scripts: `install_vim.sh` checks for vim and installs it if missing, `update_packages.sh` upgrades everything and logs the output."

---

### 📖 Step 1 — Show & explain `install_vim.sh`

```bash
cat install_vim.sh
```

**Talking points:**

1. **"Rubric **D1** asks me to install vim if it's missing, otherwise print `Vim is already installed`. The script defines `PACKAGE="vim"` as a constant."**

2. **"`dpkg -s "${PACKAGE}" 2>/dev/null | grep -q "^Status: install ok installed"` — `dpkg -s` queries the package database; the `grep` looks for the exact status string that means it's installed. I redirect stderr because `dpkg -s` complains loudly if the package isn't known."**

3. **"If that grep succeeds — package is installed — I print exactly `Vim is already installed` (the rubric phrase) and exit 0."**

4. **"Otherwise I run `apt-get update -y` followed by `DEBIAN_FRONTEND=noninteractive apt-get install -y vim`. The `DEBIAN_FRONTEND` flag prevents the install from stopping for interactive prompts — important for unattended automation."**

---

### 📺 Step 2 — Run `install_vim.sh` and explain output

#### Run 1 — vim missing → installs
```bash
./install_vim.sh
```

> *"`[INFO] Vim is not installed. Installing now...` followed by apt's progress. At the end: `[OK] Vim installed successfully.` and `vim --version | head -1` confirms what version landed."*

#### Run 2 — vim now installed → "already installed" branch
```bash
./install_vim.sh
```

> *"This time the output is just `Vim is already installed` — that's the exact rubric phrase. The script took the fast path because `dpkg -s` matched. Rubric D1 covered."*

---

### 📖 Step 3 — Show & explain `update_packages.sh`

```bash
cat update_packages.sh
```

**Talking points:**

5. **"Rubric **D2** — update everything and save output to `update.log`. The script defines `LOGFILE="update.log"` as a constant."**

6. **"It writes a banner with the date and hostname to the log file using `> "${LOGFILE}"` (truncate-then-write)."**

7. **"Then a single grouped command — `apt-get update -y; apt-get upgrade -y; apt-get autoremove -y` — has its **stdout AND stderr** appended to `update.log` via `>> "${LOGFILE}" 2>&1`. The `2>&1` is critical because apt's progress reports go to stderr."**

8. **"After the update finishes, `tail -n 10 "${LOGFILE}"` shows the last few lines so the operator gets immediate feedback."**

---

### 📺 Step 4 — Run `update_packages.sh` and explain output

```bash
./update_packages.sh
```

> *"You see `[INFO] Updating package lists...` and `[INFO] Output will be saved to: ...update.log`. The script is silent during apt because all that output is being captured."*

> *"When apt finishes, the script prints the last 10 lines of `update.log` so we can confirm everything worked."*

```bash
ls -l update.log
echo "---- first 5 lines ----"
head -5 update.log
echo "---- last 10 lines ----"
tail -10 update.log
```

> *"`update.log` exists, contains the banner, and the apt-get output is in there. Rubric D2 satisfied — packages updated, output saved."*

---

### Closing
> "Part D complete. `install_vim.sh` correctly handles both branches with the exact rubric phrase, and `update_packages.sh` runs the update and writes everything to `update.log`."

## 🛑 STOP RECORDING

---

## 💬 If you misspeak

Restart from one of:
- Top (`cat install_vim.sh`)
- "Run 1..." (`./install_vim.sh` first time)
- "Run 2..." (`./install_vim.sh` second time)
- "Now the update script..." (`cat update_packages.sh`)
- "Run it..." (`./update_packages.sh`)

---

## Rubric coverage

| Rubric | Where |
|---|---|
| D1 — vim install + "already installed" message | Two runs of `install_vim.sh` |
| D2 — apt update + log file | `./update_packages.sh` + `tail update.log` |
