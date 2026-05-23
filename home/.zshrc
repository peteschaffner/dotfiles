# Homebrew environment
eval "$(/opt/homebrew/bin/brew shellenv)"

# PATH
export PATH="$HOME/.local/bin:$PATH"

# Completion system
autoload -Uz compinit
compinit

# Case-insensitive completion; also treat . _ - as separators
zstyle ':completion:*' matcher-list \
  'm:{a-z}={A-Z}' \
  'r:|[._-]=* r:|=*'

# Colorize completion lists (uses LS_COLORS from coreutils/dircolors)
autoload -Uz colors && colors
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Use a menu UI when there are multiple matches
zmodload zsh/complist
zstyle ':completion:*' menu select
zstyle ':completion:*:descriptions' format '%F{yellow}%d%f'
zstyle ':completion:*:messages' format ''
zstyle ':completion:*:warnings' format '%F{red}no matches%f'
zstyle ':completion:*' completer _complete _approximate
zstyle ':completion:*:approximate:*' max-errors 2,accept

# History
HISTFILE=${HISTFILE:-$HOME/.zsh_history}
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY            # don’t overwrite the history file
setopt INC_APPEND_HISTORY_TIME   # push each command to $HISTFILE immediately (with timestamps)
setopt SHARE_HISTORY             # merge history across sessions

# Nice-to-haves (optional)
setopt HIST_IGNORE_SPACE         # commands starting with space aren’t saved
setopt HIST_IGNORE_DUPS          # don’t record the same command twice in a row
setopt HIST_REDUCE_BLANKS        # trim superfluous spaces
setopt EXTENDED_HISTORY          # timestamp + duration in history file

# Prompt: cwd (branch) %
setopt prompt_subst
autoload -Uz vcs_info

zstyle ':vcs_info:git*' formats '(%b)'
zstyle ':vcs_info:*' enable git

precmd() {
  vcs_info
  # Only add the branch part if vcs_info has content
  if [[ -n $vcs_info_msg_0_ ]]; then
    GIT_BRANCH=" %F{magenta}${vcs_info_msg_0_}%f"
  else
    GIT_BRANCH=""
  fi
}

# Prompt: path [branch] %
PROMPT='%F{blue}%~%f${GIT_BRANCH} %# '

# Aliases
c() {
  if [[ $PWD == $HOME ]]; then
    cd /tmp
  fi
  claude --dangerously-skip-permissions "$@"
}
