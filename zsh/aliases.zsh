##################################
# SURGICAL ALIASES - High Performance
##################################

# --- File Management ---
alias ll='ls -lh'
alias la='ls -lah'
alias ..='cd ..'
alias mkdir='mkdir -p'

# --- Editor (Consolidated) ---
alias v='nvim'
alias zshconfig='v ~/.config/zsh/.zshrc'

# --- Process & System ---
alias trash='mv --target-directory=$HOME/.Trash'
alias psf='ps auxf'
alias update='sudo pacman -Syu'
alias reload='source $HOME/.config/zsh/.zshrc'
alias ports='netstat -tulanp'
alias myip='curl ifconfig.me && echo'

# --- Physics (Domain Specific) ---
alias mount_gpu='sshfs melashri@gpu:~/inference-engine $HOME/projects/lhcb/inference-engine -o reconnect,ServerAliveInterval=15,ServerAliveCountMax=3,cache=no,uid=$(id -u),gid=$(id -g)'
# Use 'activate-physics' function for the heavy lifting, keep aliases clean.

# --- Utilities ---
alias cpv='rsync -ah --info=progress2'
alias h='history'
alias c='clear'
alias :q='exit'

# --- Dev Enviorments ---
# Enter the box, or start it if it's currently stopped
alias ai="distrobox enter ai-dev"
# Useful for running web servers, databases, or training scripts
alias ai-bg="distrobox-stop -n ai-dev >/dev/null 2>&1; distrobox-create -n ai-dev --image fedora:latest --start"
# Run a specific command in the background without entering the shell
alias ai-run="distrobox-host-exec -n ai-dev --"
