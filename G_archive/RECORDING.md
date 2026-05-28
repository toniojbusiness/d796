# Part G — Recording Script

**Goal of this video:** demonstrate `archive_etc.sh`:
1. Defines `fileSize()`. [G1]
2. Archives `/etc` with `tar + gzip`. [G2]
3. Archives `/etc` with `tar + bzip2`. [G3]
4. Calls `fileSize()` on each archive. [G4]
5. Prints the size difference between gzip and bzip2. [G5]

Estimated length: **2–3 minutes** (bzip2 takes a moment).

---

## 0. Setup BEFORE you hit record

```bash
sudo -i
cd ~/D796/G_archive
chmod +x archive_etc.sh

# Remove any prior archives so the demo is clean
rm -f /tmp/etc_backup.tar.gz /tmp/etc_backup.tar.bz2

clear
```

---

## 🔴 1. START RECORDING

### Narration line 1
> "This is Part G — archive `/etc` with both gzip and bzip2, then compare the two compression sizes using a `fileSize()` function."

### Demo step 1 — show the script
```bash
cat archive_etc.sh
```

Briefly highlight (or read aloud):
- The `fileSize()` function using `stat -c%s`.
- The `tar -czf` line (gzip) and the `tar -cjf` line (bzip2).
- The two `fileSize()` calls and the difference calculation.

### Demo step 2 — run it
```bash
./archive_etc.sh
```
**Expected output (excerpt):**
```
============================================================
Archiving /etc with tar + gzip ...
------------------------------------------------------------
[OK]   Created /tmp/etc_backup.tar.gz

============================================================
Archiving /etc with tar + bzip2 ...
------------------------------------------------------------
[OK]   Created /tmp/etc_backup.tar.bz2

============================================================
Compressed archive sizes (via fileSize)
------------------------------------------------------------
  gzip  :       2840531 bytes  (2.7MiB)
  bzip2 :       2436711 bytes  (2.3MiB)

============================================================
Difference between the two compression algorithms
------------------------------------------------------------
  bzip2 was smaller than gzip by 403820 bytes (394KiB).
============================================================
```

### Demo step 3 — verify the two archives exist
```bash
ls -lh /tmp/etc_backup.tar.gz /tmp/etc_backup.tar.bz2
file /tmp/etc_backup.tar.gz /tmp/etc_backup.tar.bz2
```

### Narration line 2
> "Both archives created, sizes pulled by `fileSize()`, and the difference reported. End of Part G."

---

## 🛑 2. STOP RECORDING

---

## Rubric coverage for this video

| Rubric | Where it's shown |
|---|---|
| G1 — `fileSize()` implemented | Demo step 1 |
| G2 — gzip archive of `/etc` | Demo step 2 + step 3 |
| G3 — bzip2 archive of `/etc` | Demo step 2 + step 3 |
| G4 — sizes determined via `fileSize()` | Demo step 2 ("via fileSize") |
| G5 — difference displayed | Demo step 2 final block |
