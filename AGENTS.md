# scripts - personal bash environment

## This checkout is live
- Must live at `~/scripts` (paths are hard-coded). `~/.bashrc` sources `bashrc_all`, which adds `~/scripts` and `~/scripts/bin` to `PATH` and sources `bashrc_common` and `bin/z.sh`.
- Edits apply to every new interactive shell. `bashrc_all` is sourced after `~/.bashrc`'s own aliases and `~/.bash_aliases`, so repo aliases win (e.g. `ls`, `ll`, `l`).
- `bashrc_*` files are sourced, not executed: never `exit` at top level (it closes the user's shell); use `return`.
- Not live: `.screenrc` is a copy installed to `~/.screenrc`, and `install_git_alias.sh` writes global git config. Changes need re-copying/re-running; don't run the installer as a test.

## Where things go
- Shell aliases/functions: the matching banner section of `bashrc_common`, not `~/.bashrc`.
- `git <alias>` aliases: `install_git_alias.sh`. Shell aliases that wrap git: GIT section of `bashrc_common`.
- Document helpers with a `#DOC <CATEGORY>: <usage> - <description>` comment (`MISC` or `INVESTIGATION`). Nothing parses these; it's a convention.
- `bin/z.sh` (rupa/z) and `bin/diff-so-fancy` are upstream copies: update by replacing, not editing. The installer sets the global git pager to `diff-so-fancy` by name, so it must stay in `~/scripts/bin`.

## Multiple machines
- Loaded on WSL2 and on other Linux hosts. Guard machine-specific additions, e.g. `[ -d /mnt/c/src ] && alias cdsrc='cd /mnt/c/src'`.
- yum, screen, tldr, notify-send and vncconfig are missing on the WSL box but may exist on other hosts; don't remove code that uses them as dead.

## Verify
- Syntax: `bash -n bashrc_common bashrc_all` (shellcheck isn't installed).
- Agent tool shells are non-interactive, so `~/.bashrc` returns early and repo aliases/functions aren't defined there. Test with `bash -ic '<alias-or-function> ...'`; ignore the job-control warnings on stderr.
