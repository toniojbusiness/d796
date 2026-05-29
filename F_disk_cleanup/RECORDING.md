# Part F — `disk_cleanup.sh` — Recording Teleprompter

> 📌 **How to use this file:** Read every 🎙️ **SAY** block out loud, word for word.
> When you see ⌨️ **TYPE**, run that command and wait for it to finish.

---

## ⚠️ Setup — DO this BEFORE you press Record

```bash
sudo -i
cd ~/d796/F_disk_cleanup
chmod +x disk_cleanup.sh

# Generate junk so the FIRST run actually frees space
mkdir -p /var/log/d796_demo /root/.cache/d796_demo
dd if=/dev/zero of=/var/log/d796_demo/junk.bin     bs=1M count=20 2>/dev/null
dd if=/dev/zero of=/root/.cache/d796_demo/junk.bin bs=1M count=20 2>/dev/null
sync

clear
```

---

## 🔴 RECORDING STARTS HERE

### 🎙️ SAY
> "Hello, my name is Tonio Jenkins. This is Part F of the WGU D796 RQN1 task. In this part I will demonstrate the disk cleanup script. The script captures the free disk space on the root partition, defines a `cleanDir` function, declares a list of directories to clean, iterates over that list with a for loop, and reports the difference in free space at the end."

### 🎙️ SAY
> "Let me show you the code first."

### ⌨️ TYPE
```bash
cat disk_cleanup.sh
```

### 🎙️ SAY
> "Near the top of the script, the line `SPACE_BEFORE_KB` runs `df --output=avail /` and stores the available kilobytes on the root partition into a variable. This satisfies rubric item F1 — finding free space using the df command and storing it in a variable."

### 🎙️ SAY
> "Below that is the `cleanDir` function, which satisfies rubric item F2. It takes one argument — a directory path — validates that the argument was given and the directory exists, then uses `find` with `-mindepth 1` and `-exec rm -rf` to delete everything inside the directory while keeping the directory itself."

### 🎙️ SAY
> "Next is the `DIRS_TO_CLEAN` array, which satisfies rubric item F3. It contains `/var/log`, the home cache directory, and `/tmp`."

### 🎙️ SAY
> "Below that is the for loop, which satisfies rubric item F4. It iterates over the array and calls `cleanDir` on each element."

### 🎙️ SAY
> "After the loop, the script reads `df` again, calculates the difference in kilobytes, and either reports the freed amount or prints exactly the words `No significant disk space was freed`. This is the rubric phrase from F5."

### 🎙️ SAY
> "Now I will run the script. Off camera I created some junk files in those directories, so this first run should actually free space."

### ⌨️ TYPE
```bash
./disk_cleanup.sh
```

### 🎙️ SAY
> "The output shows the free space before the cleanup, the list of directories about to be cleaned, the cleanup happening for each directory through the for loop, the free space after the cleanup, and the difference reported in kilobytes and approximate megabytes. F1 through F5 are all working."

### 🎙️ SAY
> "Now to demonstrate the second branch of F5, I will run the script again. The directories are already empty, so the difference will be zero."

### ⌨️ TYPE
```bash
./disk_cleanup.sh
```

### 🎙️ SAY
> "The last line of the output is `No significant disk space was freed` — verbatim the rubric phrase. Both branches of rubric item F5 are demonstrated. This completes Part F. F1 through F5 all covered. Thank you."

## 🛑 STOP RECORDING

---

## Rubric coverage

| Rubric | Where |
|---|---|
| F1 — `df` captures into a variable | The first run's "Free space on / before cleanup" line |
| F2 — `cleanDir()` correctly implemented | The `cat` block + the `[OK] cleaned` lines |
| F3 — list variable contains required dirs | The "Directories to clean" output |
| F4 — `for` loop calls `cleanDir()` | The first run's per-directory output |
| F5 — diff reported, including "No significant disk space was freed" | First run (positive) + second run (zero) |
