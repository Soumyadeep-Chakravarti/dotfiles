# ============================
# ZSH Configuration - Optimized
# ============================

export ZDOTDIR="$HOME/.config/zsh"

# Source additional configuration files - ALL CONFIGURATIONS ARE NOW HERE
for config_file in environment.zsh aliases.zsh config.zsh functions.zsh tricks.zsh m_nvim.zsh; do
    [[ -f "$ZDOTDIR/$config_file" ]] && source "$ZDOTDIR/$config_file"
done

[[ -f ~/cli/m_nvim.zsh ]] && source ~/cli/m_nvim.zsh

# Init tools
eval "$(atuin init zsh)"
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

# ============================
# Oh My Zsh
# ============================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnosterzak"
plugins=(
    git
    archlinux
    zsh-autosuggestions
    zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh

# ============================
# CLI bling: fastfetch + pokemon-colorscripts
# ============================
pokemon-colorscripts --no-title -s -r | fastfetch -c "$HOME/.config/fastfetch/config-pokemon.jsonc" \
    --logo-type file-raw --logo-height 10 --logo-width 5 --logo -


# ============================
# FZF integration
# ============================
source <(fzf --zsh)

# ============================
# History
# ============================
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# ============================
# Homebrew (Linuxbrew)
# ============================
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# ============================
# SDKMAN (must be at the end)
# ============================
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"


# ============================
# Nix environment
# ============================
if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
    source "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi
eval "$(/home/sammy/.local/bin/mise activate zsh)"
