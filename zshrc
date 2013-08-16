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
export GIT_EDITOR=/usr/local/bin/vim
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

### Aliases ###
# rsync
alias rsx="rsync-synchronize --exclude-from '${ZDOTDIR:-$HOME}/.rsyncignore'"

# Git
eval "$(hub alias -s)"
alias gdt='git difftool'

# z, but with fasd
alias z='j'

# trim new lines and copy to clipboard
alias trimcopy="tr -d '\n' | pbcopy"

# recursively delete `.DS_Store` files
alias cleanup="find . -name '*.DS_Store' -type f -ls -delete"

# vim
alias v="vim"

# hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# component
alias c="component"

# bower
alias bower='noglob bower'

### Functions ###
# Start an HTTP server from a directory, optionally specifying the port
function server() {
  local port="${1:-8000}"
  open "http://localhost:${port}/" && python -m SimpleHTTPServer "$port"
}
