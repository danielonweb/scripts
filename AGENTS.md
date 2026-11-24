# scripts - personal bash environment

## This checkout is live
- Must live at `~/scripts` (paths are hard-coded). `~/.bashrc` sources `bashrc_all`, which adds `~/scripts` and `~/scripts/bin` to `PATH` and sources `bashrc_common` and `bin/z.sh`.
- Edits apply to every new interactive shell. `bashrc_all` is sourced after `~/.bashrc`'s own aliases and `~/.bash_aliases`, so repo aliases win (e.g. `ls`, `ll`, `l`).
- `bashrc_*` files are sourced, not executed: never `exit` at top level (it closes the user's shell); use `return`.
- Not live: `install_git_alias.sh` writes global git config, so changes to it apply only when it's re-run; don't run it just to test it. `.screenrc` is symlinked to `~/.screenrc` (README step 4), but machines set up before that may still have a copy.

## Where things go
- Shell aliases/functions: the matching banner section of `bashrc_common`, not `~/.bashrc`.
- `git <alias>` aliases: `install_git_alias.sh`. Shell aliases that wrap git: GIT section of `bashrc_common`.
- Document helpers with a `#DOC <CATEGORY>: <usage> - <description>` comment (`MISC` or `INVESTIGATION`). Nothing parses these; it's a convention.
- `bin/z.sh` (rupa/z) and `bin/diff-so-fancy` are upstream copies: update by replacing, not editing. For diff-so-fancy, use the `diff-so-fancy` file attached to the GitHub release; the one in its source tree needs a `lib/` folder and fails here.
- The installer sets `core.pager` and `interactive.diffFilter` to `diff-so-fancy` by name, so it must stay in `~/scripts/bin`. `bashrc_all` appends that folder to `PATH` after `/usr/bin`, so an installed copy (e.g. Ubuntu's `/usr/bin/diff-so-fancy` on the WSL box) wins and the bundled one is only a fallback.

## Multiple machines
- Loaded on WSL2 and on other Linux hosts. Guard machine-specific additions, e.g. `[ -d /mnt/c/src ] && alias cdsrc='cd /mnt/c/src'`.
- yum, screen, tldr, notify-send and vncconfig are missing on the WSL box but may exist on other hosts; don't remove code that uses them as dead.

## Verify
- Syntax: `bash -n bashrc_common bashrc_all` (shellcheck isn't installed).
- Agent tool shells are non-interactive, so `~/.bashrc` returns early and repo aliases/functions aren't defined there. Test with `bash -ic '<alias-or-function> ...'`; ignore the job-control warnings on stderr.
- Bundled diff-so-fancy: test it directly with `git diff --color=always | ~/scripts/bin/diff-so-fancy` in a repo with changes; plain `git diff` doesn't run it where another copy is installed.

## Deploying to a machine
Follow the README's "Installation" (or "Updating" if `~/scripts` is already this repo), and:
- Clone to exactly `~/scripts` with the README's HTTPS URL. If `~/scripts` exists, check that it's this repo (`origin` points at `danielonweb/scripts`, over HTTPS or SSH); if it isn't, stop and ask. Don't change git remotes or SSH config; pushing uses the user's own SSH setup.
- `~/.bashrc`: only append the `bashrc_all` line, with the README's command (it skips the line if it's already there). Don't edit anything else in it.
- Before running `install_git_alias.sh`, check which global git settings it would change; it overwrites them without asking. This prints only settings that are already set to a different value. If it prints anything, show it to the user and wait for a go-ahead:
  `bash -c 'git() { printf "%s\t%s\n" "$3" "$4"; }; . ~/scripts/install_git_alias.sh' | while IFS=$'\t' read -r k v; do c=$(git config --global --get "$k") && [ "$c" != "$v" ] && printf '%s\n  now: %s\n  new: %s\n' "$k" "$c" "$v"; done`
- `.screenrc`: only if the user uses screen. Use a symbolic link (`ln -s`), not a copy or hard link: `git pull` replaces the file, and those would keep the old version. If `~/.screenrc` exists, show `diff ~/.screenrc ~/scripts/.screenrc` and replace it only with the user's OK.
- bat and fzf are optional: ask first. Install them with the distribution's package manager (apt, or e.g. dnf on Fedora). That needs sudo; if sudo asks for a password, give the user the command to run. If the distribution doesn't provide a tool, find out how to install it on that system from the tool's current upstream instructions (linked in the README), and tell the user what you'll do before doing it.
- Don't add bat or fzf setup to `~/.bashrc` yourself: `bashrc_common` already makes `bat` an alias for `batcat` and turns on fzf's key bindings. (fzf's own installer adds a line that sources `~/.fzf.bash`; `bashrc_common` then skips its fzf setup.)
- If fzf is already installed in `~/.fzf`, don't also install the package: `/usr/bin/fzf` would come first in `PATH`, and one older than 0.48 (e.g. Ubuntu 24.04's 0.44) makes `~/.fzf.bash` fail with "unknown option: --bash". If you run fzf's own installer, use `~/.fzf/install --all`: without options it waits for answers on stdin.
- If `git pull --ff-only` refuses, the machine has its own changes or commits: show them (`git status`, `git log @{u}..`) and ask. Never reset, stash or force-push.
- Check the result: `bash -ic 'type -t witch ll z'` prints `function`, `alias`, `alias`, and, if the installer ran, `git -C ~/scripts st` works. If `bash -ic 'type -P diff-so-fancy'` shows the bundled copy, test it as in "Verify" (it needs Perl 5.14+).
- Finish by telling the user to open a new terminal; shells that are already open don't pick up the changes.
