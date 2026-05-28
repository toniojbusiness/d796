# Part F — Recording Script

**Goal of this video:** demonstrate `disk_cleanup.sh`:
1. Captures `df` free space on `/` before cleanup. [F1]
2. Defines `cleanDir()`. [F2]
3. Defines the list of directories to clean (`/var/log`, `$HOME/.cache`, `/tmp`). [F3]
4. Loops with a `for` loop and calls `cleanDir()`. [F4]
5. Reports the difference; if zero, prints "No significant disk space was freed". [F5]

Estimated length: **2 minutes**.

---

## 0. Setup BEFORE you hit record

```bash
sudo -i
cd ~/D796/F_disk_cleanup
chmod +x disk_cleanup.sh

# Generate some junk so the cleanup actually frees space (optional but makes
# the demo more interesting on a fresh VM).
mkdir -p /var/log/d796_demo /root/.cache/d796_demo
dd if=/dev/zero of=/var/log/d796_demo/junk.bin       bs=1M count=20 2>/dev/null
dd if=/dev/zero of=/root/.cache/d796_demo/junk.bin   bs=1M count=20 2>/dev/null
sync

clear
```

---

## 🔴 1. START RECORDING

### Narration line 1
> "This is Part F — disk cleanup. The script captures free space, defines `cleanDir`, iterates over a list of directories, then reports the difference."

### Demo step 1 — show the script (highlight the four key blocks)
```bash
cat disk_cleanup.sh
```

While `cat`-ing, point out (or briefly read aloud):
- The `df --output=avail /` line saving to `SPACE_BEFORE_KB`.
- The `cleanDir()` function.
- The `DIRS_TO_CLEAN` array.
- The `for dir in ... cleanDir "$dir" ; done` loop.
- The final `if (( DIFF_KB > 0 ))` reporting block.

### Demo step 2 — run it
```bash
./disk_cleanup.sh
```
**Expected output (excerpt):**
```
============================================================
Disk cleanup — start
Free space on / before cleanup: 6.4G (6710300 KB)
============================================================

Directories to clean:
  - /var/log
  - /root/.cache
  - /tmp

  [INFO] Cleaning /var/log ...
  [OK]   /var/log cleaned.
  [INFO] Cleaning /root/.cache ...
  [OK]   /root/.cache cleaned.
  [INFO] Cleaning /tmp ...
  [OK]   /tmp cleaned.

============================================================
Disk cleanup — done
Free space on / after cleanup:  6.5G (6750100 KB)
============================================================
Freed 39800 KB (~38 MB) of disk space.
```

### Narration line 2
> "Free space went up — the script reported the exact difference. If we re-ran it now, the directories are already empty, so it would print `No significant disk space was freed`."

### Demo step 3 (optional but recommended) — re-run to trigger the zero branch
```bash
./disk_cleanup.sh
```
**Expected output (last line):**
```
No significant disk space was freed
```

### Narration line 3
> "End of Part F — both branches of the report demonstrated."

---

## 🛑 2. STOP RECORDING

---

## Rubric coverage for this video

| Rubric | Where it's shown |
|---|---|
| F1 — `df` captures free space in a variable | Demo step 1 (script) + step 2 (live values) |
| F2 — `cleanDir()` correctly implemented | Demo step 1 |
| F3 — list variable contains required dirs | Demo step 1 + step 2 ("Directories to clean") |
| F4 — `for` loop calls `cleanDir()` | Demo step 1 + step 2 |
| F5 — reports diff, including "No significant disk space was freed" | Demo steps 2 and 3 |
