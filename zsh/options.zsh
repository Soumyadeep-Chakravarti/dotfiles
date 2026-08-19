# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt SHARE_HISTORY

# Completion
autoload -Uz compinit
compinit

# Safer globbing / directory handling
setopt AUTO_CD
setopt INTERACTIVE_COMMENTS
setopt NO_BEEP

# Correction
setopt CORRECT
