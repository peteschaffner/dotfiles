#
# Sets Prezto options.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Set the key mapping style to 'emacs' or 'vi'.
zstyle ':prezto:module:editor' keymap 'vi'

# Auto convert .... to ../..
zstyle ':prezto:module:editor' dot-expansion 'yes'

# Set case-sensitivity for completion, history lookup, etc.
zstyle ':prezto:*:*' case-sensitive 'no'

# Color output (auto set to 'no' on dumb terminals).
zstyle ':prezto:*:*' color 'yes'

# Auto set the tab and window titles.
zstyle ':prezto:module:terminal' auto-title 'yes'

# Set the Zsh modules to load (man zshmodules).
# zstyle ':prezto:load' zmodule 'attr' 'stat'

# Set the Zsh functions to load (man zshcontrib).
# zstyle ':prezto:load' zfunction 'zargs' 'zmv'

# Set the Prezto modules to load (browse modules).
# The order matters.
zstyle ':prezto:load' pmodule \
  'environment' \
  'terminal' \
  'editor' \
  'history' \
  'directory' \
  'spectrum' \
  'utility' \
  'completion' \
  'node' \
  'osx' \
  'rsync' \
  'ruby' \
  'z' \
  'syntax-highlighting' \
  'history-substring-search' \
  'prompt'

# Set the prompt theme to load.
# Setting it to 'random' loads a random theme.
# Auto set to 'off' on dumb terminals.
zstyle ':prezto:module:prompt' theme 'sorin'

# Source Prezto.
source "$PDIR/init.zsh"

# Customize to your needs...

# Put secret configuration settings in ~/.secrets
if [[ -a ~/.secrets ]] then
  source ~/.secrets
fi

# So Timing.app can track my terminal usage
PROMPT_TITLE='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
export PROMPT_COMMAND="${PROMPT_COMMAND} ${PROMPT_TITLE}; "
