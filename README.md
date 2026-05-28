# D796 — RQN1 Task 1: Creating Shell Scripts

**Student:** Tonio Jenkins
**Course:** Unix and Linux — D796
**Platform:** Ubuntu 22.04 in a GitHub Codespace (free, in-browser)

> 👉 New here? Read **`GITHUB_SETUP.md`** first. It walks you through pushing
> this folder to GitHub and opening it as a Codespace in ~10 minutes.

---

## Repository layout

```
D796/
├── README.md                 ← this file
├── WRITEUP.md                ← paste this into Microsoft Word for the primary submission
├── A_create_user/
│   ├── create_user.sh
│   └── RECORDING.md          ← step-by-step Panopto recording script for Part A
├── B_delete_user/
│   ├── delete_user.sh
│   └── RECORDING.md
├── C_shell_config/
│   ├── bash_aliases
│   ├── bashrc_additions.sh
│   └── RECORDING.md
├── D_packages/
│   ├── install_vim.sh
│   ├── update_packages.sh
│   └── RECORDING.md
├── E_network/
│   ├── flowcharts/
│   │   ├── ping_google.mmd
│   │   ├── ping_dns.mmd
│   │   ├── nslookup.mmd
│   │   └── README.md
│   ├── ping_google.sh
│   ├── ping_dns.sh
│   ├── nslookup_check.sh
│   └── RECORDING.md
├── F_disk_cleanup/
│   ├── disk_cleanup.sh
│   └── RECORDING.md
└── G_archive/
    ├── archive_etc.sh
    └── RECORDING.md
```

---

## One-time setup on the Codespace

The full step-by-step (with screenshots' worth of detail) is in
`GITHUB_SETUP.md`. The short version:

```bash
# from your Mac terminal — push to GitHub once
cd /Users/tonioamz/workplace/school/D796
git init
git add .
git commit -m "WGU D796 RQN1 Task 1 — initial commit"
git branch -M main
git remote add origin git@github.com:<YOUR_GH_USERNAME>/d796.git
git push -u origin main
```

Then on github.com → your repo → green **Code** button → **Codespaces** tab
→ **Create codespace on main**. The container builds itself.

### Verify everything is ready (run inside the Codespace terminal)

```bash
cd /workspaces/d796
ls
which vim ping nslookup tar gzip bzip2 stat df chage useradd userdel
```

If anything is missing, re-run:

```bash
bash .devcontainer/setup.sh
```

---

## Recording strategy (Panopto — Rubric H)

You're submitting **7 short videos** (one per part A–G). For each part:

1. Open the corresponding `RECORDING.md`.
2. Run the **Setup** commands first (these prep the environment so your video stays clean).
3. Click record in Panopto. Make sure your face camera + screen are both visible.
   Capture the **whole browser window** so the Codespace terminal is in the frame.
4. Follow the **Demo** commands in order and read the **Narration** lines.
5. Stop recording and upload to the Panopto drop box for D796.

Each video is ~2–4 minutes. If you mess up, you only re-record that one part.

---

## Submission checklist

- [ ] 7 Panopto videos uploaded → URLs added to the Links option in the WGU portal
- [ ] Primary write-up (`WRITEUP.md` → Word .docx) uploaded as Attachment
- [ ] All `.sh` files attached
- [ ] `bash_aliases` and `bashrc_additions.sh` attached
- [ ] Three flowchart PNGs attached (rendered from the `.mmd` files — see `E_network/flowcharts/README.md`)
- [ ] Two `/etc/passwd` screenshots/captures attached (one showing user added, one showing user deleted)
- [ ] APA references included in WRITEUP

---

## Quick command index (per rubric letter)

| Part | What runs | Key rubric phrase |
|------|-----------|-------------------|
| A | `sudo ./create_user.sh devuser` | Creates `dev_group`, adds user, assigns password, displays `/etc/passwd` |
| B | `sudo ./delete_user.sh devuser` | Confirms deletion, removes home dir, displays `/etc/passwd` |
| C | source `~/.bashrc` | `$` prompt with colored prompt vs. shell text, aliases file, `bin/` in PATH |
| D | `sudo ./install_vim.sh` & `sudo ./update_packages.sh` | "Vim is already installed", `update.log` written |
| E | `./ping_google.sh`, `./ping_dns.sh`, `./nslookup_check.sh` | "Network is up." |
| F | `sudo ./disk_cleanup.sh` | df-based; `cleanDir()`; "No significant disk space was freed." |
| G | `sudo ./archive_etc.sh` | `fileSize()`; gzip + bzip2; size difference |
