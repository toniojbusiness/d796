# Part E — Network Connection Scripts — Recording Teleprompter

> 📌 **How to use this file:** Read every 🎙️ **SAY** block out loud, word for word.
> When you see ⌨️ **TYPE**, run that command and wait for it to finish.

---

## ⚠️ Setup — DO this BEFORE you press Record

```bash
cd ~/d796/E_network
chmod +x ping_google.sh ping_dns.sh nslookup_check.sh

# Make sure ping and nslookup are installed
sudo apt-get update -qq
sudo apt-get install -y -qq dnsutils iputils-ping

clear
```

Render the three flowcharts to PNG ahead of time (see `flowcharts/README.md`).
Have them open in browser tabs so you can switch to them quickly during the recording.

---

## 🔴 RECORDING STARTS HERE

### 🎙️ SAY
> "Hello, my name is Tonio Jenkins. This is Part E of the WGU D796 task. In this part I will demonstrate three network connectivity scripts: one that pings google.com, one that pings the Google DNS server at eight dot eight dot eight dot eight, and one that uses nslookup to resolve example dot com. I will also show the three flowcharts I drew for these scripts."

### 🎙️ SAY
> "First, the three flowcharts."

> 🎬 *(Switch to the browser tab showing your three flowchart PNG images. Show each one for about three seconds while reading the next line.)*

### 🎙️ SAY
> "Each flowchart shows the same general structure: start, set the variables, run the network command, check the exit code, and print either the success message or the failure message. One flowchart per script."

> 🎬 *(Switch back to the terminal.)*

### 🎙️ SAY
> "Now the first script — ping google."

### ⌨️ TYPE
```bash
cat ping_google.sh
```

### 🎙️ SAY
> "The script defines three constants: the target is google dot com, the count is three packets, and the timeout is five seconds per packet. The `ping` command sends three ICMP echo requests, and I redirect both standard output and standard error to dev null because the script only cares about the exit code. If ping returns zero — meaning a reply was received — the script prints `Network is up.`"

### 🎙️ SAY
> "Now I will run it."

### ⌨️ TYPE
```bash
./ping_google.sh
```

### 🎙️ SAY
> "The script printed `Network is up.` The first network connectivity check passes."

### 🎙️ SAY
> "Now the second script — ping the Google DNS IP."

### ⌨️ TYPE
```bash
cat ping_dns.sh
```

### 🎙️ SAY
> "This script has the same structure as the previous one, but the target is the literal IP address eight dot eight dot eight dot eight, which is Google's public DNS server. The script uses ping rather than a DNS lookup."

### 🎙️ SAY
> "Now I will run it."

### ⌨️ TYPE
```bash
./ping_dns.sh
```

### 🎙️ SAY
> "The output confirms the connection to Google DNS at eight dot eight dot eight dot eight is up."

### 🎙️ SAY
> "Now the third script — DNS lookup with nslookup."

### ⌨️ TYPE
```bash
cat nslookup_check.sh
```

### 🎙️ SAY
> "The script sets the domain to example dot com. It first checks that the nslookup command is installed. Then it runs nslookup against the domain, captures the full output, and uses awk to pull the resolved IP addresses out of the answer section. If at least one address is found, the script prints a confirmation along with the IP."

### 🎙️ SAY
> "Now I will run it."

### ⌨️ TYPE
```bash
./nslookup_check.sh
```

### 🎙️ SAY
> "The first part of the output is the raw nslookup response — it shows the DNS server, the name example dot com, and the resolved IP address. Below that is my script's confirmation: `DNS for example.com is working`, followed by the resolved IP. This completes Part E. Three flowcharts shown, three scripts demonstrated. Thank you."

## 🛑 STOP RECORDING

---

## Rubric coverage (for your reference — do NOT mention in the video)

| Rubric | Where |
|---|---|
| E1 — three flowcharts | The browser tab section at the top |
| E2 — pings google.com | `./ping_google.sh` |
| E2a — "Network is up." | The output of `./ping_google.sh` |
| E3 — pings 8.8.8.8 | `./ping_dns.sh` |
| E4 — nslookup of example.com | `./nslookup_check.sh` |
