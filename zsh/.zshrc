export ZDOTDIR="$HOME/.config/zsh"

# Core config files
source "$ZDOTDIR/environment.zsh"
source "$ZDOTDIR/config.zsh"
source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/functions.zsh"
source "$ZDOTDIR/tricks.zsh"
source "$ZDOTDIR/m_nvim.zsh"

# Optional external overrides
[[ -f ~/cli/m_nvim.zsh ]] && source ~/cli/m_nvim.zsh

