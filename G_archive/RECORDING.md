# Part G — `archive_etc.sh` — Recording Teleprompter

> 📌 **How to use this file:** Read every 🎙️ **SAY** block out loud, word for word.
> When you see ⌨️ **TYPE**, run that command and wait for it to finish.

---

## ⚠️ Setup — DO this BEFORE you press Record

```bash
sudo -i
cd ~/d796/G_archive
chmod +x archive_etc.sh

# Clean any leftover archives
rm -f /tmp/etc_backup.tar.gz /tmp/etc_backup.tar.bz2

# Make sure bzip2 is installed
apt-get install -y -qq bzip2 >/dev/null

clear
```

---

## 🔴 RECORDING STARTS HERE

### 🎙️ SAY
> "Hello, my name is Tonio Jenkins. This is Part G of the WGU D796 RQN1 task. In this part I will demonstrate the archive script. The script defines a `fileSize` function, archives the etc directory using both gzip and bzip2 compression, and reports the size of each archive and the difference between them."

### 🎙️ SAY
> "Let me show you the code first."

### ⌨️ TYPE
```bash
cat archive_etc.sh
```

### 🎙️ SAY
> "Near the top, the `fileSize` function satisfies rubric item G1. It takes one argument — a file path — validates that the argument was given and the file exists, then uses `stat -c%s` to return the size of the file in bytes."

### 🎙️ SAY
> "The next block runs `tar -czf` against the etc directory. The `-c` flag means create, `-z` means use gzip, and `-f` writes to the named file. This satisfies rubric item G2 — archive and compress the etc directory using tar and gzip."

### 🎙️ SAY
> "The block after that is the same idea, but uses `tar -cjf`. The `-j` flag uses bzip2 instead of gzip. This satisfies rubric item G3 — archive and compress the same etc directory using tar and bzip2."

### 🎙️ SAY
> "Below that, the script calls `fileSize` on each archive and stores the result in a variable. This satisfies rubric item G4 — calculating the size of the two compressed files using the `fileSize` function."

### 🎙️ SAY
> "Finally, the script subtracts the bzip2 size from the gzip size and prints the difference, indicating which compression algorithm produced the smaller file. This satisfies rubric item G5."

### 🎙️ SAY
> "Now I will run the script. The bzip2 archive will take a few seconds to create."

### ⌨️ TYPE
```bash
./archive_etc.sh
```

### 🎙️ SAY
> "The output shows the gzip archive being created, then the bzip2 archive being created. The next section is titled `Compressed archive sizes via fileSize` — both sizes were measured by my function, satisfying rubric item G4. The final section displays the difference between the two algorithms in bytes, satisfying rubric item G5."

### 🎙️ SAY
> "Let me also verify with native tools that the archives are real."

### ⌨️ TYPE
```bash
ls -lh /tmp/etc_backup.tar.gz /tmp/etc_backup.tar.bz2
file /tmp/etc_backup.tar.gz /tmp/etc_backup.tar.bz2
```

### 🎙️ SAY
> "`ls -lh` shows the file sizes match what `fileSize` reported. The `file` command confirms one is a gzip archive and the other is a bzip2 archive — both are valid compressed tarballs. This completes Part G. The `fileSize` function is implemented and used, gzip and bzip2 archives are created, and the difference between the two algorithms is displayed. G1 through G5 all covered. Thank you."

## 🛑 STOP RECORDING

---

## Rubric coverage

| Rubric | Where |
|---|---|
| G1 — `fileSize()` implemented | The `cat archive_etc.sh` walkthrough |
| G2 — gzip tar | "Created /tmp/etc_backup.tar.gz" line |
| G3 — bzip2 tar | "Created /tmp/etc_backup.tar.bz2" line |
| G4 — sizes via `fileSize()` | "Compressed archive sizes (via fileSize)" block |
| G5 — difference displayed | "Difference between the two compression algorithms" block |
