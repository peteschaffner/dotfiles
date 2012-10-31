#
# Executes commands at login pre-zshrc.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Fix for MacVim executed via the Finder, etc.
# It seems vim processes aren't launched in a login-shell.
if [[ -a ~/.zshrc ]] then
  source ~/.zshrc
fi
