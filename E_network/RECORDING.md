# Part E — Network Connection Scripts

## 📋 Teacher's 4-step flow
1. **Prepare an error-free script first.**
2. **Start recording.**
3. **Explain the code, then explain the output.**
4. **Stop recording.**

> 🎯 Goal: ~5-minute video covering all three scripts + the three flowcharts. Code walkthrough + live run + output explanation for each.

---

## ⚠️ DO BEFORE you press Record

```bash
cd ~/d796/E_network
chmod +x ping_google.sh ping_dns.sh nslookup_check.sh

# Make sure ping and nslookup are installed
sudo apt-get update -qq
sudo apt-get install -y -qq dnsutils iputils-ping

clear
```

Render the three flowcharts to PNG ahead of time (see `flowcharts/README.md`). Have them open in another tab so you can show them on camera.

---

## 🔴 START RECORDING

### Intro
> "Part E — three network connectivity scripts. I'll start with the flowcharts that document the planned logic, then walk through each script's code, then run them and explain the output."

---

### 📖 Step 1 — Show the three flowcharts (rubric E1)

Open the three rendered PNGs (or `cat` the `.mmd` source if you didn't render):

```bash
cat flowcharts/ping_google.mmd
cat flowcharts/ping_dns.mmd
cat flowcharts/nslookup.mmd
```

> *"Three flowcharts — one per script. Each one shows the entry point, the variable setup, the network command, the decision diamond on the exit code, and the two terminal outputs. Rubric E1 satisfied."*

---

### 📖 Step 2 — Show & explain `ping_google.sh`

```bash
cat ping_google.sh
```

**Talking points:**

1. **"`TARGET="google.com"`, `COUNT=3`, `TIMEOUT=5` — three readonly constants for the target host, packet count, and per-packet timeout."**

2. **"`ping -c "${COUNT}" -W "${TIMEOUT}" "${TARGET}"` sends three ICMP echo requests with a 5-second wait per packet. I redirect both stdout and stderr to `/dev/null` because the script only cares about the exit code."**

3. **"If `ping` returns 0 — at least one reply received — I print exactly `Network is up.` (the rubric phrase) and exit 0. Otherwise I print a failure message and exit 1."**

### 📺 Run it and explain output

```bash
./ping_google.sh
```

**Expected:**
```
[INFO] Pinging google.com (3 packets, 5s timeout)...
Network is up.
```

> *"`[INFO]` line confirms the target. Then `Network is up.` — exactly the rubric phrase. Rubric E2 and E2a satisfied."*

---

### 📖 Step 3 — Show & explain `ping_dns.sh`

```bash
cat ping_dns.sh
```

**Talking points:**

4. **"Identical structure to `ping_google.sh`, but the target is `8.8.8.8` — Google's public DNS resolver. Rubric E3 specifically says to use ping against the IP, not DNS lookup, so this is a literal ICMP ping by IP address."**

### 📺 Run it and explain output

```bash
./ping_dns.sh
```

**Expected:**
```
[INFO] Pinging Google DNS at 8.8.8.8 (3 packets, 5s timeout)...
Connection to Google DNS (8.8.8.8) is up.
```

> *"`Connection to Google DNS (8.8.8.8) is up.` — rubric E3 satisfied. The IP is correct, ping is the tool, the result is reported."*

---

### 📖 Step 4 — Show & explain `nslookup_check.sh`

```bash
cat nslookup_check.sh
```

**Talking points:**

5. **"`DOMAIN="example.com"` — the rubric explicitly names this domain."**

6. **"First I `command -v nslookup` to make sure the binary is installed; if not, I print an install hint and exit. This makes the script self-documenting."**

7. **"`nslookup "${DOMAIN}" 2>&1` runs the lookup and captures the full output (stdout + stderr) into `NSLOOKUP_OUTPUT`."**

8. **"The `awk` pipeline parses the answer section — anything after the `Name:` line and any subsequent `Address:` lines — to extract just the resolved IPs. If we got at least one address, we print a confirmation and the IP."**

### 📺 Run it and explain output

```bash
./nslookup_check.sh
```

**Expected (excerpt):**
```
Server:   ...
Name:     example.com
Address:  93.184.216.34

DNS for example.com is working. Resolved address(es):
93.184.216.34
```

> *"The first chunk is the raw nslookup output — server it queried, the name, and the address. Then my script's confirmation: `DNS for example.com is working.` followed by the resolved IP. Rubric E4 satisfied — nslookup correctly resolved example.com."*

---

### Closing
> "Part E complete. Three flowcharts shown, three scripts walked through, three live runs with the rubric-required output strings. E1 through E4 covered."

## 🛑 STOP RECORDING

---

## 💬 If you misspeak

Restart from one of:
- "Three flowcharts..." (cat the .mmd files)
- "First script — ping google..." (`cat ping_google.sh`)
- "Second script — ping DNS..." (`cat ping_dns.sh`)
- "Third script — nslookup..." (`cat nslookup_check.sh`)

---

## Rubric coverage

| Rubric | Where |
|---|---|
| E1 — three flowcharts | Step 1 |
| E2 — pings google.com | `./ping_google.sh` |
| E2a — "Network is up." | output of `./ping_google.sh` |
| E3 — pings 8.8.8.8 | `./ping_dns.sh` |
| E4 — nslookup of example.com | `./nslookup_check.sh` |
