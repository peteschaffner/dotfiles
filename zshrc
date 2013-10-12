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
export GIT_EDITOR=vim
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

### Aliases ###
# rsync
alias rsx="rsync-synchronize --exclude-from '${ZDOTDIR:-$HOME}/.rsyncignore'"

# Mercurial
alias h='hg'
alias hs='hg status'
alias hl='hg log -G'
alias hd='hg diff'
alias hD='hg ksdiff'
alias hc='hg commit'
alias hC='hg record'
alias hb='hg branch'
alias hbc='hg branch'
alias hbl='hg branches'
alias hco='hg checkout'
alias hgb='hg gb'
alias hcd='hg cd'
# Trim trailing whitespace from any of the changed files that
# that are JavaScript, CSS or Stylus files... then open a diff
alias hws='hg status -mn | sed -E -n "/\.js|styl|css$/p" | xargs sed -i "" "s, *$,," && hg ksdiff'

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
alias v='vim'

# hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# component
alias c='component'

# bower
alias bower='noglob bower'

### Functions ###
# Start an HTTP server from a directory, optionally specifying the port
function server() {
  local port="${1:-8000}"
  open "http://localhost:${port}/" && python -m SimpleHTTPServer "$port"
}
