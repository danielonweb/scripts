# script

## Installation steps
1. Clone this repo
2. Add the following to .bashrc
```
[ -f ~/scripts/bashrc_all ] && . ~/scripts/bashrc_all
```
3. copy .screenrc to ~
```
cp .screenrc ~/
```

## Additional productivity tools
### z
https://github.com/rupa/z/
### bat
https://github.com/sharkdp/bat#installation
### diff-so-fancy
https://github.com/so-fancy/diff-so-fancy#install
### Command line fuzzy finder
```
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```
From (https://github.com/junegunn/fzf#installation)

## Adding Beyond Compare support with WSL/Windows Sub System
Edit ~/.gitconfig with
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
wslpath is builtin tool for conveting WSL and windows paths

hack taken from - https://www.scootersoftware.com/vbulletin/forum/beyond-compare-4-discussion/version-control-aa/14411-new-updates-in-windows-wsl
