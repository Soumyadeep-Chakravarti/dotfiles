# =====================================
# config.zsh — ZSH / Shell Configurations
# =====================================

# ----------------------------
# Shell Options
# ----------------------------
# Enable extended globbing for advanced pattern matching
setopt extended_glob

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# ----------------------------
# Oh My Zsh
# ----------------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="dracula-pro"

plugins=(
    git
    zsh-autosuggestions
    insult-zsh
    you-should-use
    adguard-helper
)

# Load Oh My Zsh
[[ -f "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

# ----------------------------
# CLI Enhancements
# ----------------------------
# Starship prompt (if installed)
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
fi

# Atuin shell plugin
eval "$(atuin init zsh)"

# FZF integration
[[ -f "$(command -v fzf)" ]] && source <(fzf --zsh)

# Fastfetch + Pokemon colorscripts
[[ -f "$(command -v fastfetch)" ]] && \
[[ -f "$(command -v pokemon-colorscripts)" ]] && \
    pokemon-colorscripts --no-title -s -r | fastfetch -c "$HOME/.config/fastfetch/config-pokemon.jsonc" \
        --logo-type file-raw --logo-height 10 --logo-width 5 --logo -

# ----------------------------
# Custom Aliases & Functions
# ----------------------------
# Aliases loaded from aliases.zsh
[[ -f "$ZDOTDIR/aliases.zsh" ]] && source "$ZDOTDIR/aliases.zsh"
# Functions loaded from functions.zsh
[[ -f "$ZDOTDIR/functions.zsh" ]] && source "$ZDOTDIR/functions.zsh"
# Tricks / utilities
[[ -f "$ZDOTDIR/tricks.zsh" ]] && source "$ZDOTDIR/tricks.zsh"

# ----------------------------
# Environment Overrides (Optional)
# ----------------------------
[[ -f ~/cli/m_nvim.zsh ]] && source ~/cli/m_nvim.zsh

# ----------------------------
# Verification Commands (Optional)
# ----------------------------
# Uncomment to check important paths/tools
# which python3
# python3 --version
# nvcc --version
# echo $PATH | tr ':' '\n'

# ----------------------------
# Notes:
# - Keep environment variables in environment.zsh
# - Keep shell-specific tweaks, prompts, plugins, aliases here
# - Optional scripts loaded at the end
# ----------------------------

