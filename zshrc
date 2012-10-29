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
eval "$(hub alias -s)"
alias tt='python ~/path/to/t.py --task-dir ~/Dropbox --list tasks'
alias t='python ~/path/to/t.py --task-dir . --list tasks'
alias b='python ~/path/to/t.py --task-dir . --list bugs'
