# Docker Desktop — Local Ubuntu for D796

Codespaces giving you trouble? Run a real Ubuntu container right on your Mac.
This is faster, fully offline once installed, and records cleanly with
QuickTime + Panopto.

Your Mac: Apple Silicon (arm64), macOS Tahoe 26, Homebrew installed. ✅

---

## Step 1 — Install Docker Desktop (one-time, ~5 min)

```bash
brew install --cask docker
```

Then **open Docker Desktop** from Spotlight (`Cmd+Space` → "Docker") and:
1. Click **Accept** on the agreement.
2. Choose **Use recommended settings** when asked.
3. **Skip the sign-in.** You don't need a Docker account for this.
4. Wait until the whale icon in the macOS menu bar stops animating
   (~1 minute).

Verify it's running:

```bash
docker version
```

You should see both a Client section AND a Server section. If only the
Client section shows, Docker Desktop is still starting — wait 30 seconds.

---

## Step 2 — Launch the D796 Ubuntu container

Run this command. It mounts your project folder into `/workspace/D796`
inside the container so any edits you make on either side are immediately
visible on the other.

```bash
docker run -it --rm \
    --name d796 \
    -v /Users/tonioamz/workplace/school/D796:/workspace/D796 \
    -w /workspace/D796 \
    ubuntu:22.04 \
    bash -c "apt-get update -qq && \
             DEBIAN_FRONTEND=noninteractive apt-get install -y -qq \
                 vim iputils-ping dnsutils bzip2 sudo passwd adduser procps && \
             find . -name '*.sh' -exec chmod +x {} \; && \
             exec bash"
```

The first time this runs:
- Docker downloads the `ubuntu:22.04` image (~30 MB, one-time).
- Apt installs the few extra tools we need (~30 seconds).
- It drops you into a `root@<container-id>:/workspace/D796#` prompt.

Subsequent launches will be much faster (~10 seconds). The image stays
cached.

---

## Step 3 — Verify everything works

Inside the container:

```bash
ls
which vim ping nslookup tar gzip bzip2 stat df chage useradd userdel
echo "I am: $(whoami) (uid $(id -u))"
```

You should already be **root** (uid 0), so you won't even need `sudo` for
the rubric demos. The `RECORDING.md` files all use `sudo` — that still
works (it's a no-op as root) but you can also drop the `sudo` if you
prefer cleaner output.

---

## Step 4 — Record from your Mac

Because the container is local, you'll record your Mac's screen normally:

- **Panopto** desktop recorder (or QuickTime → New Screen Recording)
- Make sure the camera is on and shows you in the corner
- Capture the full Terminal.app window where the container is running

Each `RECORDING.md` (in `A_create_user/`, `B_delete_user/`, ...) tells you
exactly what to type and say.

---

## Quick reference

| Task | Command |
|---|---|
| Start the container | `docker run -it --rm --name d796 -v /Users/tonioamz/workplace/school/D796:/workspace/D796 -w /workspace/D796 ubuntu:22.04 bash` |
| Re-attach if you opened a new terminal tab | `docker exec -it d796 bash` |
| Stop / kill the container | inside container: `exit` (because of `--rm` it auto-deletes) |
| Reset to a fresh container | just stop and rerun Step 2 |
| Free up space later (optional) | `docker system prune -a` |

> **Note on `--rm`:** The container is deleted on exit, so changes you make
> *inside the container* (like creating users with `useradd`) disappear.
> Your **scripts and project files are safe** because they live in
> `/Users/tonioamz/workplace/school/D796` on your Mac and are mounted in.
> If you want changes to persist between sessions, drop `--rm` and use
> `docker start d796 -ai` to resume.

---

## When something goes wrong

| Symptom | Fix |
|---|---|
| `Cannot connect to the Docker daemon` | Open Docker Desktop, wait for the whale icon |
| `Error response from daemon: Conflict ... name "/d796" is already in use` | `docker rm -f d796` then rerun |
| `permission denied` running a `.sh` | inside container: `chmod +x A_create_user/*.sh ...` |
| Slow first launch | normal — image download. Re-runs are fast. |
| Want a non-root user | `useradd -m -s /bin/bash demo && su - demo`, but rubric demos need root |
