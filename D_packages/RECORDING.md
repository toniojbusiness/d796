# Part D — Recording Script

**Goal of this video:**
1. Show `install_vim.sh` correctly detecting an already-installed vim and
   printing the required message; then (optionally) demonstrate it installing
   vim when it is missing. [D1]
2. Show `update_packages.sh` running `apt update && apt upgrade` and writing
   to `update.log`. [D2]

Estimated length: **2–3 minutes** (plus apt running time).

---

## 0. Setup BEFORE you hit record

```bash
sudo -i
cd ~/D796/D_packages
chmod +x install_vim.sh update_packages.sh

# Remove any stale log so the demo creates a fresh one
rm -f update.log

clear
```

If you want to demo BOTH branches of `install_vim.sh` (already installed AND
fresh install), uninstall vim before recording:

```bash
apt-get remove -y vim vim-runtime vim-common 2>/dev/null || true
```

---

## 🔴 1. START RECORDING

### Narration line 1
> "This is Part D — package management. Two scripts: install vim, then update everything and log the output."

### Demo command 1 — show the install script
```bash
cat install_vim.sh
```

### Demo command 2 — D1: run install_vim.sh (vim missing → installs it)
```bash
./install_vim.sh
```
**Expected output (if vim was uninstalled):**
```
[INFO] Vim is not installed. Installing now...
... apt output ...
[OK]   Vim installed successfully.
VIM - Vi IMproved 9.x ...
```

### Demo command 3 — D1: run install_vim.sh again (vim now installed)
```bash
./install_vim.sh
```
**Expected output:**
```
Vim is already installed
VIM - Vi IMproved 9.x ...
```

### Narration line 2
> "Second run prints exactly `Vim is already installed`, satisfying D1."

### Demo command 4 — show the update script
```bash
cat update_packages.sh
```

### Demo command 5 — D2: run update_packages.sh and view the log
```bash
./update_packages.sh
ls -l update.log
echo "---- first 5 lines of update.log ----"
head -5 update.log
echo "---- last 10 lines of update.log ----"
tail -10 update.log
```

### Narration line 3
> "All installed packages were updated and the full output was saved to `update.log`. End of Part D."

---

## 🛑 2. STOP RECORDING

---

## Rubric coverage for this video

| Rubric | Where it's shown |
|---|---|
| D1 — vim install + "already installed" message | Demo commands 2 and 3 |
| D2 — apt update/upgrade + output written to `update.log` | Demo command 5 |
