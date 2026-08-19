# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Listing
alias ls='eza'
alias ll='eza -lah --icons'
alias la='eza -a --icons'
alias lt='eza --tree --level=2 --icons'

# Files
alias cat='bat --paging=never'

# Git
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'

# Neovim
alias v='nvim'
alias vi='nvim'
alias vim='nvim'

# Safety
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# terminal utils
alias c="clear"
alias :q="exit"
alias reload="source ~/.zshrc"
