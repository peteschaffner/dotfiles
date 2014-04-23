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

### Env variables ###
export PROMPT="
%F{07}λ%f "
export RPROMPT="%F{07}%2~"
export EDITOR='vim'
export GIT_EDITOR=vim

### Aliases ###
# vimpager
alias less=$PAGER
alias zless=$PAGER

# rsync
alias rsx="rsync-synchronize --exclude-from '${ZDOTDIR:-$HOME}/.rsyncignore'"

# Git
alias gdt='git difftool'
alias gdT='git difftool --cached'
alias gbX='git delete-branch'

# z, but with fasd
alias z='j'

# trim new lines and copy to clipboard
alias trimcopy="tr -d '\n' | pbcopy"

# recursively delete `.DS_Store` files
alias cleanup="find . -name '*.DS_Store' -type f -ls -delete"

# vim
alias v='vim'

# hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# component
alias c='component'
