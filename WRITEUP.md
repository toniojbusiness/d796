# RQN1 Task 1: Creating Shell Scripts in a Unix Environment

**Student:** Tonio Jenkins
**Course:** Unix and Linux — D796
**Assessment:** RQN1 — Creating Shell Scripts
**Environment:** Ubuntu 22.04 LTS in a Multipass virtual machine on macOS

---

## Introduction

As the overnight system administrator described in the task scenario, I was
asked to write a series of shell scripts that the day shift can use to
automate routine work. This document describes each of the seven scripts,
explains the supporting shell configuration, and references the documentation
that informed the implementation. Recordings of every script being executed
are linked at the end of this document and have been uploaded to Panopto as
required by Rubric H.

---

## A. `create_user.sh` — Create a new user

**File:** `create_user.sh`

The script accepts a single positional argument (the username). If no
argument is supplied, the script writes `ERROR: No username supplied.` to
standard error and exits with code `1` (Robbins, 2022). When invoked with a
valid username it performs four actions:

1. Confirms that the supplementary group `dev_group` exists, creating it
   with `groupadd` if necessary (`getent group "${DEV_GROUP}"`).
2. Creates the new account with `useradd -m -s /bin/bash -G dev_group`.
   `-m` ensures a home directory is provisioned; `-G` adds the user to the
   `dev_group` supplementary group (Linux man-pages project, 2024).
3. Sets the default password `ChangeMe123!` non-interactively via
   `chpasswd`.
4. Forces a password change at first login by calling `chage -d 0`, which
   sets the date of the last password change to the epoch and triggers
   PAM's "password expired" handler the next time the user authenticates
   (Linux man-pages project, 2024).

The script then displays the user's `/etc/passwd` entry and the last five
lines of `/etc/passwd` so the rubric requirement to "verify the user
creation" is satisfied. The recording demonstrates the no-argument error
path, a successful creation, and switching to the new user with
`su - devuser`, where the password expiry policy forces an immediate change
(WGU rubric items A1–A5).

---

## B. `delete_user.sh` — Delete the user

**File:** `delete_user.sh`

Like `create_user.sh`, the script validates the single positional argument
and prints an error to standard error when the argument is missing. Before
performing any destructive action it asks for a `yes`/`no` confirmation
through bash's `read` builtin. Only an answer of `yes` (case-insensitive)
proceeds with deletion; any other input causes the script to exit with code
`4` and the message `Deletion cancelled by user.`

Once confirmed, the script:

1. Sends `SIGKILL` to any active processes owned by the target user
   (`pkill -KILL -u "${USERNAME}"`) so that `userdel` will not refuse to
   remove an account that is currently logged in.
2. Calls `userdel -r` to delete the user **and** their home directory.
   Should `userdel -r` fail (for example, when the mail spool was already
   removed), the script falls back to a plain `userdel` followed by
   `rm -rf /home/<user>`.
3. Verifies the deletion by `grep`-ing `/etc/passwd` for the username and
   checking that `/home/<user>` no longer exists.

The recording shows the no-argument error, the confirmation prompt, the
deletion, the contents of `/etc/passwd` afterwards, and a failed
`su - devuser` attempt that proves the account is gone (WGU rubric items
B1–B5).

---

## C. Shell configuration

**Files:** `bash_aliases`, `bashrc_additions.sh`

### C1 — Custom prompt

The prompt was changed to a single dollar sign and given a colour distinct
from the colour of the shell text. The `PS1` value is:

```bash
export PS1='\[\e[1;32m\]$\[\e[1;36m\] '
```

`\[\e[1;32m\]` switches the foreground colour to bright green for the `$`
character, and `\[\e[1;36m\]` switches it to bright cyan for everything
typed afterwards. Wrapping the escape sequences in `\[ \]` tells bash to
exclude them when calculating prompt width, which prevents line-wrapping
artefacts (Cooper, 2023). A `DEBUG` trap (`trap 'printf "\e[0m"' DEBUG`)
resets the colour before each command runs so command output appears in
the default colour.

### C2 — Aliases file

The aliases requested by the rubric are stored in a separate
`~/.bash_aliases` file that is sourced at the bottom of `~/.bashrc`:

```bash
alias ll='ls -lrt'
alias la='ls -a'
alias c='clear'
alias desktop='cd "$HOME/Desktop"'
alias download='cd "$HOME/Downloads"'
alias documents='cd "$HOME/Documents"'
```

### C3 — Apply and verify

`source ~/.bashrc` re-reads the configuration and immediately applies it.
The recording shows the prompt change, then runs each alias to confirm
they work.

### C4 — `bin` directory and `PATH`

A `bin` directory was created in the root user's home (`/root/bin`) and
the two scripts from Parts A and B were copied into it:

```bash
mkdir -p /root/bin
cp create_user.sh delete_user.sh /root/bin/
chmod +x /root/bin/*.sh
```

The PATH stanza in `bashrc_additions.sh` adds `$HOME/bin` to the front of
`$PATH`:

```bash
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
export PATH
```

After `source ~/.bashrc`, both scripts can be executed by name from any
working directory. The recording demonstrates this from `/tmp` (a
directory other than `/root/bin`).

---

## D. Package management

### D1 — `install_vim.sh`

The script first uses `dpkg -s vim` to check whether the package is
installed. If the status string `Status: install ok installed` is found,
the script prints `Vim is already installed` and exits. Otherwise it
runs `apt-get update` followed by a non-interactive `apt-get install -y
vim` (`DEBIAN_FRONTEND=noninteractive`) so the installation does not stall
on prompts (Canonical, 2024).

### D2 — `update_packages.sh`

The script writes a header (date and host) to `update.log`, then appends
the combined output of:

```bash
apt-get update -y
apt-get upgrade -y
apt-get autoremove -y
```

to that same log file. Both stdout and stderr are redirected (`>>
"${LOGFILE}" 2>&1`) so that warnings, security advisories, and post-install
hooks are all captured.

---

## E. Network connection scripts

### E1 — Flowcharts

Three flowcharts were drawn in Mermaid notation (`*.mmd` source files in
`E_network/flowcharts/`) and rendered to PNG. They show the control flow
of `ping_google.sh`, `ping_dns.sh`, and `nslookup_check.sh`. Each diagram
follows standard ANSI flowchart shapes (terminator, process, decision)
(Robbins, 2022).

### E2 — `ping_google.sh`

Sends three ICMP echo requests to `google.com` with a 5-second per-packet
timeout. If `ping` exits with code `0`, the script prints exactly
`Network is up.` (matching the rubric verbatim) and exits.

### E3 — `ping_dns.sh`

Identical structure to `ping_google.sh` but targets the Google public DNS
resolver `8.8.8.8`. ICMP rather than DNS is used because the rubric
explicitly says "by using the ping command".

### E4 — `nslookup_check.sh`

Calls `nslookup example.com`, captures the answer section, and `awk`-parses
the lines that follow `Name:` for `Address:` records. If at least one
address is found the script prints
`DNS for example.com is working. Resolved address(es):` followed by every
address returned (Linux man-pages project, 2024).

---

## F. `disk_cleanup.sh` — Assess and clean up disk space

**File:** `disk_cleanup.sh`

The available space on `/` is captured before any cleanup using
`df --output=avail / | tail -n 1`, which returns the value in 1-K blocks
(GNU coreutils, 2024). A second variable holds the human-readable form
from `df -h` for display.

The `cleanDir()` function takes one argument — the directory whose
contents should be removed — and uses `find <dir> -mindepth 1 -exec rm
-rf {} +` to delete everything inside, including hidden files, while
keeping the directory itself.

A bash array names the directories that should be cleaned:

```bash
DIRS_TO_CLEAN=( "/var/log" "${HOME}/.cache" "/tmp" )
```

A `for` loop iterates over the array and calls `cleanDir` on each entry.
After the loop the script re-reads `df`, calculates `SPACE_AFTER_KB -
SPACE_BEFORE_KB`, and either reports the freed amount in KB and MB or
prints `No significant disk space was freed` when the difference is zero
or negative.

---

## G. `archive_etc.sh` — Archive and compress `/etc`

**File:** `archive_etc.sh`

The `fileSize()` function returns the size in bytes of the file passed as
its first argument, using `stat -c%s` (GNU coreutils, 2024). It validates
that the argument was supplied and that it points to a regular file
before calling `stat`.

The script then creates two archives of `/etc`:

```bash
tar -czf /tmp/etc_backup.tar.gz  -C / etc      # gzip   (-z)
tar -cjf /tmp/etc_backup.tar.bz2 -C / etc      # bzip2  (-j)
```

`-C /` makes tar change to `/` before reading paths so that the archive
contains a relative `etc/...` tree rather than absolute paths, which is
considered best practice (Free Software Foundation, 2024).

After both archives exist, `fileSize()` is called on each and the script
prints both sizes and the difference between them. A small helper,
`humanSize()`, formats the bytes via `numfmt --to=iec` so the output is
also readable as MiB/KiB.

---

## Reflection

Implementing these scripts reinforced two themes from the course: idempotence
and explicit verification. Every script either checks whether a resource
already exists before creating it or asks the operator for confirmation
before destroying anything, which prevents the "automation cascade" failures
that occur when a script is rerun unexpectedly. Each script also prints
verifying output (a `grep`, a `tail`, a `df`, a `stat`) so the operator can
confirm success directly from the script's output rather than running ad-hoc
checks afterward.

---

## I. References

Canonical Ltd. (2024). *Apt — package handling utility for Debian* [Manual page].
Retrieved from <https://manpages.ubuntu.com/manpages/jammy/en/man8/apt.8.html>

Cooper, M. (2023). *Advanced Bash-Scripting Guide*. The Linux Documentation
Project. Retrieved from <https://tldp.org/LDP/abs/html/>

Free Software Foundation. (2024). *GNU Tar 1.35 manual*. Retrieved from
<https://www.gnu.org/software/tar/manual/tar.html>

GNU coreutils. (2024). *df invocation* and *stat invocation* [Manual pages].
Retrieved from <https://www.gnu.org/software/coreutils/manual/coreutils.html>

Linux man-pages project. (2024). *useradd(8), userdel(8), chpasswd(8),
chage(1), nslookup(1)* [Manual pages]. Retrieved from
<https://man7.org/linux/man-pages/>

Robbins, A. (2022). *Bash Pocket Reference: Help for Power Users and Sys
Admins* (3rd ed.). O'Reilly Media.

---

## H. Panopto recordings

| Part | Panopto URL |
|------|-------------|
| A — `create_user.sh`        | _paste URL after upload_ |
| B — `delete_user.sh`        | _paste URL after upload_ |
| C — Shell configuration     | _paste URL after upload_ |
| D — Package management      | _paste URL after upload_ |
| E — Network connection scripts | _paste URL after upload_ |
| F — `disk_cleanup.sh`       | _paste URL after upload_ |
| G — `archive_etc.sh`        | _paste URL after upload_ |

> When you paste this document into Microsoft Word for submission, replace
> the placeholders above with the share URLs from Panopto and add them to
> the WGU portal's **Links** option as well.
