# Part G — `archive_etc.sh`

## 📋 Teacher's 4-step flow
1. **Prepare an error-free script first.**
2. **Start recording.**
3. **Explain the code, then explain the output.**
4. **Stop recording.**

> 🎯 Goal: ~4-minute video showing the `fileSize()` function, the two tar/compress invocations, and the size-difference report.

---

## ⚠️ DO BEFORE you press Record

```bash
sudo -i
cd ~/d796/G_archive
chmod +x archive_etc.sh

# Clean any leftover archives
rm -f /tmp/etc_backup.tar.gz /tmp/etc_backup.tar.bz2

# Make sure bzip2 is available (gzip and tar are everywhere already)
apt-get install -y -qq bzip2 >/dev/null

clear
```

---

## 🔴 START RECORDING

### Intro
> "Part G — archive `/etc` with both gzip and bzip2, then compare the two compression sizes using a `fileSize()` function. I'll walk through the code, then run it, then explain the output."

---

### 📖 Step 1 — Show & explain the code

```bash
cat archive_etc.sh
```

**Talking points:**

1. **"`OUTDIR="/tmp"`, plus the two archive paths `GZIP_ARCHIVE` and `BZIP2_ARCHIVE` — readonly constants so they can't be modified."**

2. **"Rubric **G1** — `fileSize()` is the function. It takes one argument, validates that an argument was passed and that it points to a regular file, then runs `stat -c%s` which returns the size in bytes. Single-purpose, single source of truth."**

3. **"`humanSize()` is a small helper using `numfmt --to=iec` to display the size as MiB or KiB — it's just for human-readable output, not part of the rubric."**

4. **"Rubric **G2** — `tar -czf "${GZIP_ARCHIVE}" -C / etc`. `-c` create, `-z` use gzip, `-f` write to this file. The `-C /` makes tar change to root before reading paths so the archive contains a relative `etc/` tree instead of absolute paths — that's a portability best practice."**

5. **"Rubric **G3** — same idea but `-cjf` instead of `-czf`. The `-j` flag uses bzip2 instead of gzip. Same input directory, same output approach."**

6. **"Rubric **G4** — I call `fileSize "${GZIP_ARCHIVE}"` and `fileSize "${BZIP2_ARCHIVE}"`, capturing the bytes into `GZIP_SIZE` and `BZIP2_SIZE`. The function is the single source for both numbers."**

7. **"Rubric **G5** — `DIFF=$(( GZIP_SIZE - BZIP2_SIZE ))`. The `if/elif/else` checks the sign and prints which algorithm produced the smaller archive and by how many bytes."**

---

### 📺 Step 2 — Run the script and explain the output

```bash
./archive_etc.sh
```

**Walk through the output:**

> *"`Archiving /etc with tar + gzip` ... `[OK] Created /tmp/etc_backup.tar.gz` — that's rubric G2 done."*
> *"`Archiving /etc with tar + bzip2` ... `[OK] Created /tmp/etc_backup.tar.bz2` — that's rubric G3 done."*
> *"`Compressed archive sizes (via fileSize)` — note `via fileSize` in the header. The next two lines come from calling `fileSize()` on each archive: gzip is X bytes, bzip2 is Y bytes. That's rubric G4."*
> *"`Difference between the two compression algorithms` — bzip2 was smaller than gzip by Z bytes. Rubric G5."*

### 📺 Step 3 — Verify with native tools

```bash
ls -lh /tmp/etc_backup.tar.gz /tmp/etc_backup.tar.bz2
file /tmp/etc_backup.tar.gz /tmp/etc_backup.tar.bz2
```

> *"`ls -lh` shows the actual file sizes match what `fileSize()` reported. `file` confirms the gzip and bzip2 magic numbers are present — these are real, valid compressed tarballs."*

---

### Closing
> "Part G complete. `fileSize()` function defined and used twice, gzip archive created, bzip2 archive created, both sizes pulled via `fileSize()`, and the difference between the two compression algorithms reported. G1 through G5 covered."

## 🛑 STOP RECORDING

---

## 💬 If you misspeak

Restart from one of:
- Top (`cat archive_etc.sh`)
- "Now I'll run it..." (`./archive_etc.sh`)
- "Let's verify..." (`ls -lh /tmp/etc_backup.tar.*`)

---

## Rubric coverage

| Rubric | Where |
|---|---|
| G1 — `fileSize()` implemented | Code walkthrough point 2 |
| G2 — gzip tar | "Created /tmp/etc_backup.tar.gz" line |
| G3 — bzip2 tar | "Created /tmp/etc_backup.tar.bz2" line |
| G4 — sizes via `fileSize()` | "Compressed archive sizes (via fileSize)" block |
| G5 — difference displayed | "Difference between the two compression algorithms" block |
