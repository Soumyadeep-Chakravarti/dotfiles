# PATH
for dir in \
    "$HOME/.local/bin" \
    "$HOME/.opencode/bin"
do
    [[ -d "$dir" ]] && path=("$dir" $path)
done

export PATH

# zoxide
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"

# fzf
command -v fzf >/dev/null 2>&1 && source <(fzf --zsh)

# Atuin
command -v atuin >/dev/null 2>&1 && eval "$(atuin init zsh)"

# Starship
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"

# Direnv
command -v direnv >/dev/null 2>&1 && eval "$(direnv hook zsh)"
