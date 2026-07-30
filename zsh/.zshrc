# Set ZDOTDIR
export ZDOTDIR="$HOME/.config/zsh"

# Source modular files safely
[[ -f "$ZDOTDIR/environment.zsh" ]] && source "$ZDOTDIR/environment.zsh"
[[ -f "$ZDOTDIR/aliases.zsh" ]]      && source "$ZDOTDIR/aliases.zsh"
[[ -f "$ZDOTDIR/functions.zsh" ]]    && source "$ZDOTDIR/functions.zsh"

# Initialize modern tools
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"

# FZF initialization
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# --- Defensive Plugin Loading (Works on Arch AND Fedora) ---
# This looks for the most common locations, no matter the OS
typeset -a plugin_paths
plugin_paths=(
    "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
)

for p in $plugin_paths; do
    if [[ -f $p ]]; then
        source $p
        break
    fi
done

# Initialize Completion
autoload -Uz compinit && compinit


# Atuin Env (If it exists)
[[ -f "$HOME/.atuin/bin/env" ]] && . "$HOME/.atuin/bin/env"

# opencode
export PATH=/home/sammy/.opencode/bin:$PATH

# Automatically start Zellij in a new, unique session
if command -v zellij > /dev/null && [ -z "$ZELLIJ" ]; then
    zellij -s "session-$(date +%s%N)"
fi
export LIBVIRT_DEFAULT_URI=qemu:///system

if [ -e /home/sammy/.nix-profile/etc/profile.d/nix.sh ]; then . /home/sammy/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
