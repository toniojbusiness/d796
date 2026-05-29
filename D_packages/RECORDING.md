# Part D — Package Management — Recording Teleprompter

> 📌 **How to use this file:** Read every 🎙️ **SAY** block out loud, word for word.
> When you see ⌨️ **TYPE**, run that command and wait for it to finish.

---

## ⚠️ Setup — DO this BEFORE you press Record

```bash
sudo -i
cd ~/d796/D_packages
chmod +x install_vim.sh update_packages.sh

# Remove any stale log so the demo creates a fresh one
rm -f update.log

# Uninstall vim so the FIRST run of install_vim.sh actually installs it
apt-get remove -y vim vim-runtime vim-common vim-tiny 2>/dev/null || true

clear
```

---

## 🔴 RECORDING STARTS HERE

### 🎙️ SAY
> "Hello, my name is Tonio Jenkins. This is Part D of the WGU D796 RQN1 task. In this part I will demonstrate two package-management scripts: one that installs vim if it is missing, and one that updates all installed packages and saves the output to a log file."

### 🎙️ SAY
> "First, the install vim script."

### ⌨️ TYPE
```bash
cat install_vim.sh
```

### 🎙️ SAY
> "The script defines a constant for the package name, then uses `dpkg -s vim` to ask the package database whether vim is installed. The grep filters for the exact status string that means it is installed. If that grep succeeds, the script prints exactly the words `Vim is already installed` and exits — that is the rubric phrase."

### 🎙️ SAY
> "Otherwise, the script runs `apt-get update` and then `apt-get install vim`. I set `DEBIAN_FRONTEND` to noninteractive so the install does not pause for prompts. This satisfies rubric item D1."

### 🎙️ SAY
> "Now I will run the script. Vim is currently uninstalled, so this first run should trigger the install path."

### ⌨️ TYPE
```bash
./install_vim.sh
```

### 🎙️ SAY
> "The script reported that vim was not installed and proceeded to install it. At the bottom you can see the install completed and `vim --version` confirms the version that landed."

### 🎙️ SAY
> "Now I will run the same script again. This time vim is installed, so it should take the already-installed branch."

### ⌨️ TYPE
```bash
./install_vim.sh
```

### 🎙️ SAY
> "The output is exactly `Vim is already installed` — the rubric phrase. The script correctly detected that vim was already present and skipped the install. Rubric item D1 is fully satisfied."

### 🎙️ SAY
> "Now the update packages script."

### ⌨️ TYPE
```bash
cat update_packages.sh
```

### 🎙️ SAY
> "The script defines `update.log` as the log file. It writes a banner with the date and hostname to the log, then runs three commands inside a grouped block: `apt-get update`, `apt-get upgrade`, and `apt-get autoremove`. Both standard output and standard error are appended to the log file using `>> update.log 2>&1`. After the update, the script displays the last ten lines of the log so I get immediate feedback. This satisfies rubric item D2."

### 🎙️ SAY
> "Now I will run it."

### ⌨️ TYPE
```bash
./update_packages.sh
```

### 🎙️ SAY
> "The script ran. It is silent during apt because all that output is being written to the log file. When apt finished, the script printed the last ten lines of the log so we can confirm everything worked."

### 🎙️ SAY
> "Let me show you the log file directly to prove it was saved."

### ⌨️ TYPE
```bash
ls -l update.log
head -5 update.log
echo "---- last 10 lines ----"
tail -10 update.log
```

### 🎙️ SAY
> "The file `update.log` exists. The first lines show the banner the script wrote, with the date and hostname. The last lines show the apt-get output. Rubric item D2 is satisfied — packages were updated and the output is saved to `update.log`. This completes Part D. Thank you."

## 🛑 STOP RECORDING

---

## Rubric coverage

| Rubric | Where |
|---|---|
| D1 — vim install + "already installed" message | The two runs of `install_vim.sh` |
| D2 — apt update + log file | `update_packages.sh` + the `head` and `tail` of `update.log` |
