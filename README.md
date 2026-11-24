# scripts

Personal bash environment and productivity tools, used on WSL2 and other Linux hosts.
Requires bash, git, and Perl 5.14 or newer (for the bundled diff-so-fancy).

AI coding agents: read [AGENTS.md](AGENTS.md) before deploying or changing this repo.

## Installation

1. Clone the repo to exactly `~/scripts`; the scripts depend on that path. The repo is public, so HTTPS works without SSH keys:
   ```bash
   git clone https://github.com/danielonweb/scripts.git ~/scripts
   ```
2. Load it from the end of `~/.bashrc`, so its aliases (e.g. `ls`, `ll`, `l`) replace the defaults defined earlier in that file. This adds the line only if it isn't there yet:
   ```bash
   grep -qs 'scripts/bashrc_all' ~/.bashrc || echo '[ -f ~/scripts/bashrc_all ] && . ~/scripts/bashrc_all' >> ~/.bashrc
   ```
3. Set up the git aliases, and diff-so-fancy for `git diff`, `log`, `show` and `git add -p`. This writes to your global git config (`~/.gitconfig`) and replaces any of these settings you already have:
   ```bash
   ~/scripts/install_git_alias.sh
   ```
4. Only if you use GNU screen: make `~/.screenrc` a symbolic link to the repo's copy, so it stays up to date when you pull. A copy or a hard link wouldn't: `git pull` replaces the file, and they keep the old version.
   ```bash
   ln -s ~/scripts/.screenrc ~/.screenrc
   ```
   If `~/.screenrc` already exists, this fails with "File exists". Compare the two files (`diff ~/.screenrc ~/scripts/.screenrc`); if yours is an old copy of this one, replace it with `ln -sf ~/scripts/.screenrc ~/.screenrc`.
5. Open a new terminal.

To have an AI coding agent do this, ask it: "Deploy https://github.com/danielonweb/scripts on this machine. Read its AGENTS.md first and follow the 'Deploying to a machine' section."

## Updating

```bash
cd ~/scripts && git pull --ff-only && ./install_git_alias.sh
```

Then open a new terminal: `resource` reloads aliases and functions, but doesn't undo settings the repo has stopped making.
If the pull refuses, this machine has its own changes or commits; check `git status` and `git log @{u}..` first.
If `~/.screenrc` is a copy (older instructions said to copy it), switch it to a link as in Installation step 4.

## What's included

`bashrc_all` adds `~/scripts` and `~/scripts/bin` to the end of `PATH`, and loads `bashrc_common` and `bin/z.sh`.

### Bundled (no install needed)
- **bashrc_common** - Shell aliases, helper functions, and log parsing tools.
  - To list the documented helpers: `grep '#DOC' ~/scripts/bashrc_common`
  - `witch <name>` shows what a command is: an alias, function, builtin, keyword, or file.
  - Text sorts byte by byte in every shell (`LC_COLLATE=C`): `sort` is fast, and uppercase sorts before lowercase, also in `ls` and `*`. The log helpers run with `LC_ALL=C`.
- **git aliases** - Set up by `install_git_alias.sh`, e.g. `git st` (status), `git co` (checkout), `git ll` (one-line log), `git b` (branches, newest first). `git la` lists them all.
- **z** - Directory jumper ([rupa/z](https://github.com/rupa/z/)). Once you've been to a folder, `z <part of its name>` jumps back to it, e.g. `z scripts`.
- **diff-so-fancy** - Better git diffs ([so-fancy/diff-so-fancy](https://github.com/so-fancy/diff-so-fancy)). Configured by `install_git_alias.sh` as the git pager and for `git add -p`.
  - If diff-so-fancy is also installed system-wide (e.g. `apt install diff-so-fancy`), git uses that copy instead, because `bashrc_all` adds `~/scripts/bin` at the end of `PATH`. The bundled copy is the fallback.
  - To update it, download the `diff-so-fancy` file attached to the [latest release](https://github.com/so-fancy/diff-so-fancy/releases/latest). Don't use the one from the source code: it needs a `lib/` folder next to it.
  - To test the bundled copy, even where another one is installed, run this in a repo with uncommitted changes: `git diff --color=always | ~/scripts/bin/diff-so-fancy`
- **git_optimize_all.sh / git_optimize_once.sh** - `git_optimize_all.sh <folder>` runs `git gc --aggressive` and `git remote prune origin` in every git repo under the folder, which can take a long time on big repos. `git_optimize_once.sh` does the same in the current repo.

## Adding your own aliases

- Shell aliases and functions go in the matching section of `bashrc_common`. `git <alias>` aliases go in `install_git_alias.sh`; re-run it afterwards.
- Add a `#DOC MISC: <usage> - <description>` comment (or `#DOC INVESTIGATION:`), so the helper shows up in the `#DOC` list.
- This repo is loaded on several machines, so wrap machine-specific additions in a check, e.g. `[ -d /mnt/c/src ] && alias cdsrc='cd /mnt/c/src'`.

## External tools (install separately)

### bat
A `cat` replacement with syntax highlighting.
```bash
sudo apt install bat
```
Some Debian/Ubuntu releases, including Ubuntu 24.04, install it as `batcat`, because another package already has a `bat` command. `bashrc_common` then makes `bat` an alias for `batcat`. Aliases only work in your shell; in scripts, use `batcat`.

Fedora: `sudo dnf install bat`. If your distribution doesn't package bat, see https://github.com/sharkdp/bat#installation

### fzf
Command line fuzzy finder.
```bash
sudo apt install fzf
```
`bashrc_common` turns on its key bindings: CTRL-R searches your command history, CTRL-T inserts file names, and ALT-C changes into a folder. `**<TAB>` completes file names fuzzily, e.g. `vim **<TAB>`.

Fedora: `sudo dnf install fzf`. If your distribution doesn't package fzf, or you want a newer version (Ubuntu 24.04's is 0.44), see https://github.com/junegunn/fzf#installation.

fzf's own installer (`~/.fzf/install`) sets up the key bindings itself, in `~/.fzf.bash`, and `bashrc_common` then leaves them alone. Use either that or the package, not both: the packaged `/usr/bin/fzf` comes first in `PATH`, and if it's older than 0.48 (like Ubuntu 24.04's), `~/.fzf.bash` fails with "unknown option: --bash" and the key bindings stop working.
