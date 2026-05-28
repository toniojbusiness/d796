# Part F — `disk_cleanup.sh`

## 📋 Teacher's 4-step flow
1. **Prepare an error-free script first.**
2. **Start recording.**
3. **Explain the code, then explain the output.**
4. **Stop recording.**

> 🎯 Goal: ~4-minute video showing the script's structure (df capture, cleanDir, array, for-loop, diff report) + two runs to demo BOTH the "freed N KB" and the "No significant disk space was freed" branches.

---

## ⚠️ DO BEFORE you press Record

```bash
sudo -i
cd ~/d796/F_disk_cleanup
chmod +x disk_cleanup.sh

# Generate some junk so the FIRST run actually frees space
mkdir -p /var/log/d796_demo /root/.cache/d796_demo
dd if=/dev/zero of=/var/log/d796_demo/junk.bin     bs=1M count=20 2>/dev/null
dd if=/dev/zero of=/root/.cache/d796_demo/junk.bin bs=1M count=20 2>/dev/null
sync

clear
```

---

## 🔴 START RECORDING

### Intro
> "Part F — disk cleanup. The script captures free disk space, cleans a list of directories, then reports the difference. I'll cover all five rubric points: the df capture, the cleanDir function, the directory list, the for loop, and the difference report."

---

### 📖 Step 1 — Show & explain the code

```bash
cat disk_cleanup.sh
```

**Talking points (one paragraph each — point at the relevant block as you go):**

1. **"Rubric **F1** — `SPACE_BEFORE_KB="$(df --output=avail / | tail -n 1 | tr -d ' ')"`. `df --output=avail /` prints just the available column for the root partition; `tail -n 1` skips the header; `tr -d ' '` strips whitespace. The result is the free KB count, stored in a variable."**

2. **"I also capture `SPACE_BEFORE_HUMAN` from `df -h` for a friendly display value."**

3. **"Rubric **F2** — `cleanDir()` is the function. It takes one argument, validates it, makes sure the directory exists, then runs `find <dir> -mindepth 1 -exec rm -rf {} +`. `-mindepth 1` keeps the directory itself; everything inside gets deleted, including hidden files."**

4. **"Rubric **F3** — `DIRS_TO_CLEAN=( "/var/log" "${HOME}/.cache" "/tmp" )`. A bash array that lists every directory I want cleaned. Adding more is a one-line change."**

5. **"Rubric **F4** — `for dir in "${DIRS_TO_CLEAN[@]}"; do cleanDir "${dir}"; done`. A for loop iterates the array and calls `cleanDir` on each element."**

6. **"Rubric **F5** — after the loop I re-read `df` into `SPACE_AFTER_KB`, compute `DIFF_KB = SPACE_AFTER_KB - SPACE_BEFORE_KB`, then `if (( DIFF_KB > 0 ))` either reports the freed KB and approximate MB, or — when the difference is zero or negative — prints exactly `No significant disk space was freed`, the rubric phrase."**

---

### 📺 Step 2 — Run #1 (with junk to clean)

```bash
./disk_cleanup.sh
```

**Walk through the output:**

> *"Banner showing the start. `Free space on / before cleanup` shows the captured value — F1 working."*
> *"`Directories to clean:` lists `/var/log`, `/root/.cache`, `/tmp` — F3 working."*
> *"For each directory: `[INFO] Cleaning ...` and `[OK] ... cleaned` — that's the for-loop calling cleanDir, F4 working."*
> *"Bottom: `Free space on / after cleanup` shows the new value — note it's higher than before."*
> *"`Freed 39800 KB (~38 MB) of disk space.` — F5 working in the positive branch."*

### 📺 Step 3 — Run #2 (nothing left to clean)

```bash
./disk_cleanup.sh
```

> *"Now the directories are already empty, so the difference is zero. The last line is `No significant disk space was freed` — verbatim the rubric phrase. F5's other branch confirmed."*

---

### Closing
> "Part F complete. `df` captured into a variable, `cleanDir` function correctly implemented, directory list correct, for-loop working, and both branches of the difference report — including the exact 'No significant disk space was freed' message — demonstrated."

## 🛑 STOP RECORDING

---

## 💬 If you misspeak

Restart from one of:
- Top (`cat disk_cleanup.sh`)
- "Run 1..." (`./disk_cleanup.sh` first time)
- "Run 2..." (`./disk_cleanup.sh` second time)

---

## Rubric coverage

| Rubric | Where |
|---|---|
| F1 — `df` captures into variable | Code walkthrough point 1 + Run 1 banner |
| F2 — `cleanDir()` correctly implemented | Code walkthrough point 3 |
| F3 — list variable contains required dirs | Code walkthrough point 4 + "Directories to clean" output |
| F4 — `for` loop calls `cleanDir()` | Code walkthrough point 5 + Run 1 cleaning output |
| F5 — diff reported, including "No significant disk space was freed" | Run 1 (positive) + Run 2 (negative) |
