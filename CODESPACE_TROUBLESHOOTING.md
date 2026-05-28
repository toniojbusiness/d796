# Codespace Troubleshooting

## "Offline" / "You are offline" banner after creating the Codespace

This is almost always **the post-create script still running** — Codespaces
shows "offline" while `apt-get` is doing its first install. The container
**is** online; it just hasn't finished setup.

### What to do

1. Wait 2–3 more minutes. The banner usually clears itself.
2. Open the bottom panel: View → Terminal (or press `` Ctrl + ` ``).
3. If you don't see a terminal, click the **+** in the terminal pane to spawn one.
4. Run:
   ```bash
   echo "I am online: $(date)"
   ping -c2 github.com
   ```
   If both work, the "offline" message was a stale UI state — ignore it.

---

## The Codespace boot actually failed

If after 5 minutes you still can't open a terminal at all:

1. Go to <https://github.com/codespaces>
2. Click the **…** next to your codespace → **Stop**
3. Click **…** → **Delete**
4. Pull the latest commit (which has the trimmed setup) into your repo:
   ```bash
   cd /Users/tonioamz/workplace/school/D796
   git add .
   git commit -m "trim devcontainer for faster boot" || true
   git push
   ```
5. Recreate the codespace from your repo's green **Code** → **Codespaces** →
   **Create codespace on main**.

The new boot should take **under 60 seconds**.

---

## "Permission denied" when running a script

The first time, manually fix permissions:
```bash
cd /workspaces/d796
chmod +x A_create_user/*.sh B_delete_user/*.sh C_shell_config/*.sh \
         D_packages/*.sh E_network/*.sh F_disk_cleanup/*.sh G_archive/*.sh
```

---

## "sudo: a password is required"

Codespaces gives the `vscode` user **passwordless sudo** by default. If sudo
is asking for a password, you're probably in the wrong shell. Open a fresh
terminal:
- View → Terminal → New Terminal
- Confirm: `whoami` should print `vscode`, and `sudo -n true` should succeed.

---

## Backup plan — run things WITHOUT a Codespace

If Codespaces just won't cooperate, you can record everything from your Mac
using either of these in-browser Linux shells:

| Service | URL | Notes |
|---|---|---|
| **Replit** | <https://replit.com/~/cli/new?template=bash> | Free; gives you a real bash shell. Some `apt` packages may be restricted but `useradd`, `tar`, `gzip`, `bzip2` work. |
| **Webminal** | <https://webminal.org/> | Free Linux for learners. Browser only. |
| **JSLinux** | <https://bellard.org/jslinux/vm.html?cpu=riscv64&url=buildroot-riscv64.cfg&mem=256> | Local-only x86 Linux in your browser. |

> ⚠️ For the rubric items that need real `sudo` (creating users, apt-get,
> archiving `/etc`), Codespaces is still the most reliable. Try the
> troubleshooting steps above first.

---

## Once the Codespace IS working

You'll see a VS Code-style interface in your browser with:
- File tree on the left
- Code/markdown editor in the middle
- **Terminal** at the bottom (if not, hit `` Ctrl + ` ``)

In the terminal:
```bash
cd /workspaces/d796         # or whatever you named the repo
ls                          # confirm all the part folders are visible
which vim ping nslookup tar gzip bzip2 stat df chage useradd userdel
```

Every `which` should print a `/usr/bin/...` path. You're ready to record.
