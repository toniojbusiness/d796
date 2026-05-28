# GitHub + Codespaces — Free Linux Hosting for D796

Multipass acting up? No problem. GitHub Codespaces gives you a real Ubuntu
22.04 VM in your browser with full `sudo`, free for 60 hours per month on a
personal account — more than enough to record all seven videos.

This repo already includes a `.devcontainer/` folder, so the moment your
Codespace boots, every package the scripts need (vim, ping, nslookup, bzip2,
etc.) is installed and every `.sh` file is marked executable.

---

## One-time setup (≈10 minutes)

### 1. Make a GitHub account (if you don't have one)

Go to <https://github.com/signup>. The free tier includes 60 Codespace hours
per month and 15 GB of storage — plenty for this assignment.

### 2. Create the repository

You have two options:

#### Option A — push from your Mac (recommended)

```bash
cd /Users/tonioamz/workplace/school/D796

# Create a local git repo
git init
git add .
git commit -m "WGU D796 RQN1 Task 1 — initial commit"

# Create a NEW empty repo on github.com (private is fine).
# Then GitHub will show you a "push existing repository" command. Run it:
git branch -M main
git remote add origin git@github.com:<YOUR_GH_USERNAME>/d796.git
git push -u origin main
```

If you don't have SSH keys set up, use the HTTPS URL GitHub gives you and
authenticate when prompted.

#### Option B — upload via the GitHub website

1. <https://github.com/new> → name it `d796`, leave it empty, click Create.
2. On your Mac, drag the contents of `/Users/tonioamz/workplace/school/D796`
   into the new repo's "uploading an existing file" page.
3. Commit.

### 3. Open it in a Codespace

In your repo on github.com:

1. Click the green **Code** button (top right of the file list).
2. Switch to the **Codespaces** tab.
3. Click **Create codespace on main**.

GitHub will spin up an Ubuntu container, install the dev tools, run the
`postCreateCommand` from `.devcontainer/devcontainer.json`, and drop you into
VS Code in your browser with a real bash terminal.

The first boot takes ~2 minutes. After that, it resumes in seconds.

> 💡 If you prefer a desktop terminal feel, click `≡` (top-left in VS Code
> for Web) → **Terminal → New Terminal**. That's your Linux shell.

---

## Sanity check

In the Codespace terminal, run:

```bash
cd /workspaces/d796           # or whatever you named your repo
ls
which vim ping nslookup tar gzip bzip2 stat df chage useradd userdel
```

Every command should print a `/usr/bin/...` path. If `nslookup` is missing
re-run the setup script:

```bash
bash .devcontainer/setup.sh
```

---

## Recording from a Codespace

Codespace runs in your browser — Panopto captures whatever's on screen. For
each part:

1. Open the corresponding `RECORDING.md` (e.g. `A_create_user/RECORDING.md`)
   in a second tab so you can read it.
2. In the Codespace terminal run the **Setup** block.
3. Switch to Panopto, hit Record. Make sure:
   - Webcam is on (rubric H requires "a clear view of yourself").
   - You're capturing the full browser window (or full screen).
4. Click back into the Codespace terminal and run the **Demo** commands.
5. Stop the recording, upload, paste the URL into `WRITEUP.md`.

> 💡 Maximize the terminal pane (View → Toggle Panel Size, or drag) so the
> output is easy to read in the recorded video.

---

## When you're done

Codespaces auto-suspend after 30 minutes idle and auto-delete after 30 days.
You can also delete it manually at <https://github.com/codespaces> to keep
your hour quota safe.

Keep the **repo** — it's your submission artifact. The graders won't access
it, but you'll attach the script files from there to the WGU portal.
