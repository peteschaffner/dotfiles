#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# Put secret configuration settings in ~/.secrets
if [[ -a ~/.secrets ]] then
  source ~/.secrets
fi

# Aliases
## t
alias t='python ~/.dotfiles/t.py --task-dir ~/Dropbox --list tasks'
alias b='python ~/.dotfiles/t.py --task-dir ~/Dropbox --list bugs'

## rsync
alias rsx="rsync-synchronize --exclude-from '${ZDOTDIR:-$HOME}/.rsyncignore'"

## Git
eval "$(hub alias -s)"
alias gdt='git difftool'
