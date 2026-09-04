# zoxide
eval "$(zoxide init zsh)"

# fzf
source <(fzf --zsh)

# Atuin
eval "$(atuin init zsh)"

# Starship
eval "$(starship init zsh)"

# Direnv
eval "$(direnv hook zsh)"

export PATH=$HOME/.opencode/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"
