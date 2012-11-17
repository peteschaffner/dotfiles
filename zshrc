#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

### Source Prezto. ###
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

### Put secret configuration settings in ~/.secrets ###
if [[ -a ~/.secrets ]] then
  source ~/.secrets
fi

### Aliases ###
# commandline task list
alias t='python ~/.dotfiles/t.py --task-dir ~/Dropbox --list tasks'
alias b='python ~/.dotfiles/t.py --task-dir ~/Dropbox --list bugs'

# rsync
alias rsx="rsync-synchronize --exclude-from '${ZDOTDIR:-$HOME}/.rsyncignore'"

# Git
eval "$(hub alias -s)"
alias gdt='git difftool'

# `cat` with beautiful colors
alias c='pygmentize -O style=solarized -f console256 -g'

# z, but with fasd
alias z='j'

# trim new lines and copy to clipboard
alias trimcopy="tr -d '\n' | pbcopy"

# recursively delete `.DS_Store` files
alias cleanup="find . -name '*.DS_Store' -type f -ls -delete"

# mvim
alias v="mvim"

# hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
