# =============================================================================
# WGU D796 — RQN1 Task 1, Part C
# Append the contents of this file to ~/.bashrc (and to /root/.bashrc if you
# are demonstrating as root). Then run:  source ~/.bashrc
# =============================================================================

# ---------------------------------------------------------------------------
# C1. Custom prompt — change the prompt to "$" and color the prompt and the
#     shell text differently from one another.
#
#     Color reference (ANSI escapes wrapped in \[ \] so bash measures the
#     prompt width correctly):
#       \[\e[1;32m\]  bright green   (used for the prompt symbol)
#       \[\e[1;36m\]  bright cyan    (used for command/shell text)
#       \[\e[0m\]     reset
# ---------------------------------------------------------------------------
export PS1='\[\e[1;32m\]$\[\e[1;36m\] '

# Make the foreground text colour persist for everything the user types and
# for command output, so the prompt color and shell text color are visibly
# different (rubric C1).
trap 'printf "\e[0m"' DEBUG

# ---------------------------------------------------------------------------
# C2. Source the separate aliases file.
# ---------------------------------------------------------------------------
if [ -f "$HOME/.bash_aliases" ]; then
    . "$HOME/.bash_aliases"
fi

# ---------------------------------------------------------------------------
# C4b. Add the bin directory in the user's home (or /root for root) to PATH
#      so create_user.sh and delete_user.sh can be run from anywhere.
# ---------------------------------------------------------------------------
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
export PATH
