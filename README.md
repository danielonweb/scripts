# scripts

Personal shell environment and productivity tools.

## Installation steps

1. Clone this repo to `~/scripts`
2. Add the following to `~/.bashrc`:
```bash
[ -f ~/scripts/bashrc_all ] && . ~/scripts/bashrc_all
```
3. Copy `.screenrc` to home:
```bash
cp ~/scripts/.screenrc ~/
```
4. Set up git aliases and diff-so-fancy as the default pager:
```bash
~/scripts/install_git_alias.sh
```

## What's included

### Bundled (no install needed)
- **z** - Directory jumper ([rupa/z](https://github.com/rupa/z/)). Sourced automatically via `bashrc_all`.
- **diff-so-fancy** - Better git diffs ([so-fancy/diff-so-fancy](https://github.com/so-fancy/diff-so-fancy)). Configured by `install_git_alias.sh` as the git pager and for `git add -p`.
  - If diff-so-fancy is also installed system-wide (e.g. `apt install diff-so-fancy`), git uses that copy instead, because `bashrc_all` adds `~/scripts/bin` at the end of `PATH`. The bundled copy is the fallback.
  - To update it, download the `diff-so-fancy` file attached to the [latest release](https://github.com/so-fancy/diff-so-fancy/releases/latest). Don't use the one from the source code: it needs a `lib/` folder next to it.
  - To test the bundled copy, even where another one is installed, run this in a repo with uncommitted changes: `git diff --color=always | ~/scripts/bin/diff-so-fancy`
- **bashrc_common** - Shell aliases, helper functions, and log parsing tools.
- **git_optimize_all.sh / git_optimize_once.sh** - Git repo optimization scripts.

### External (require install)
#### bat
A `cat` replacement with syntax highlighting.
```bash
sudo apt-get install -y bat
```
See https://github.com/sharkdp/bat#installation

#### fzf
Command line fuzzy finder.
```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```
See https://github.com/junegunn/fzf#installation

## Optional: Beyond Compare with WSL

Edit `~/.gitconfig`:
```
[diff]
        tool = bc3
[difftool "bc3"]
        cmd = "$(wslpath \"c:\\Program Files\\Beyond Compare 4\\BCompare.exe\")" "$(wslpath -aw $LOCAL)" "$(wslpath -aw $REMOTE)"
[merge]
        tool = bc3
[mergetool "bc3"]
        cmd = "$(wslpath \"c:\\Program Files\\Beyond Compare 4\\BCompare.exe\")" "$(wslpath -aw $LOCAL)" "$(wslpath -aw $REMOTE)" "$(wslpath -aw $BASE)" "$(wslpath -aw $MERGED)"
        trustExitCode = true
```
`wslpath` is a built-in tool for converting WSL and Windows paths.

Source: https://www.scootersoftware.com/vbulletin/forum/beyond-compare-4-discussion/version-control-aa/14411-new-updates-in-windows-wsl
