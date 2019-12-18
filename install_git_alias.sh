#/bin/bash

# diff-so-fancy - is beautify the git deault diff tool
# to use diff-so-fancy you must has ~/scripts/bin in the PATH !
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

git config --global alias.graph "log --pretty=format:'%h: %s' --topo-order --graph"
git config --global alias.ls "diff-tree --no-commit-id --name-only -r"
git config --global alias.ll "log --pretty=\"format:%Cred%h%Creset %C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset\" --abbrev-commit --date=relative"
git config --global alias.lll "whatchanged -1"
git config --global alias.logl "log --name-status"
git config --global alias.logg "log --decorate=short --graph"
git config --global alias.logs "log --format=oneline"
git config --global alias.logsu "log --format=oneline --author='Daniel Krauthgamer'"
git config --global alias.dt difftool
git config --global alias.mt mergetool
git config --global alias.co checkout
git config --global alias.a "add -u ."
git config --global alias.st status
git config --global alias.cp cherry-pick
git config --global alias.unstage "reset HEAD --"
git config --global alias.b "!git for-each-ref --sort='-authordate' --format='%(authordate)%09%(objectname:short)%09%(refname)' refs/heads | sed -e 's-refs/heads/--'"

# list aliases
git config --global alias.la "!git config -l | grep alias | cut -c 7-"



