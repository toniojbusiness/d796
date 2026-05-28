# Part E — Recording Script

**Goal of this video:**
1. Briefly show the three flowcharts (E1).
2. Run `ping_google.sh` and show "Network is up." (E2 + E2a).
3. Run `ping_dns.sh` against 8.8.8.8 (E3).
4. Run `nslookup_check.sh` against example.com (E4).

Estimated length: **2–3 minutes**.

---

## 0. Setup BEFORE you hit record

```bash
cd ~/D796/E_network
chmod +x ping_google.sh ping_dns.sh nslookup_check.sh

# Make sure nslookup is available
sudo apt install -y dnsutils iputils-ping >/dev/null 2>&1

clear
```

Render the three flowchart PNGs (one-time, before you record) — see
`flowcharts/README.md`. You'll briefly show the PNGs in the video.

---

## 🔴 1. START RECORDING

### Narration line 1
> "This is Part E — three network connectivity scripts. I'll start by showing the flowcharts that document the planned logic."

### Demo step 1 — E1: show the three flowcharts
- Open the three rendered PNGs (`ping_google.png`, `ping_dns.png`, `nslookup.png`)
  side-by-side or one-after-another in your viewer for a couple of seconds each.
- Or `cat` the `.mmd` source files briefly:
```bash
cat flowcharts/ping_google.mmd
cat flowcharts/ping_dns.mmd
cat flowcharts/nslookup.mmd
```

### Demo step 2 — E2: run the google.com ping
```bash
cat ping_google.sh
./ping_google.sh
```
**Expected output:**
```
[INFO] Pinging google.com (3 packets, 5s timeout)...
Network is up.
```

### Narration line 2
> "First script prints exactly `Network is up.` — that's E2a satisfied."

### Demo step 3 — E3: run the 8.8.8.8 ping
```bash
cat ping_dns.sh
./ping_dns.sh
```
**Expected output:**
```
[INFO] Pinging Google DNS at 8.8.8.8 (3 packets, 5s timeout)...
Connection to Google DNS (8.8.8.8) is up.
```

### Demo step 4 — E4: run nslookup against example.com
```bash
cat nslookup_check.sh
./nslookup_check.sh
```
**Expected output (excerpt):**
```
Server:   ...
Name:     example.com
Address:  93.184.216.34
...
DNS for example.com is working. Resolved address(es):
93.184.216.34
```

### Narration line 3
> "All three connectivity checks passed. End of Part E."

---

## 🛑 2. STOP RECORDING

---

## Rubric coverage for this video

| Rubric | Where it's shown |
|---|---|
| E1 — three flowcharts | Demo step 1 |
| E2 — script pings google.com | Demo step 2 |
| E2a — prints "Network is up." | Demo step 2 output |
| E3 — pings 8.8.8.8 | Demo step 3 |
| E4 — uses nslookup to resolve example.com | Demo step 4 |
