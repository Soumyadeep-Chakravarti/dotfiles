##################################
# ALIASES.ZSH - User Aliases
##################################

########## SYSTEM INFORMATION ##########
alias showdate='echo "Today is $(date)"'
alias printdir='echo "The current directory is: $(pwd)"'
alias listfiles='echo "The files in this directory are: $(ls)"'
alias showcpu='echo "Current CPU usage: $(mpstat 1 1 | awk '\''/all/ {print 100 - $NF "%"}'\'')"'
alias showmem='echo "Memory usage: $(awk '"'"'/MemTotal|MemAvailable/{if ($1=="MemTotal:") total=$2; else if ($1=="MemAvailable:") available=$2} END{printf "%.2f%% used", (total-available)/total*100}'"'"' /proc/meminfo)"'
alias showdisk='echo "Disk usage: $(df -h | awk '\''$NF=="/"{print $5}'\'')"'
alias mycpu='echo "Your CPU usage: $(ps -u $USER -o %cpu= | awk '\''{sum+=$1} END {printf "%.2f%%", sum}'\'')"'

########## FILE & DIRECTORY MANAGEMENT ##########
alias ll='ls -l'
alias la='ls -la'
alias l.='ls -d .* --color=auto'
alias ..='cd ..'
alias mkdir='mkdir -p'
alias t='tree -L 1'

########## EXIT COMMANDS ##########
alias :q='exit'
alias ext='exit'
alias xt='exit'
alias by='exit'
alias bye='exit'
alias die='exit'
alias quit='exit'
alias e='exit'

########## FILE VIEWING & EDITING ##########
alias zshrc='cat ~/.zshrc'
alias zshconfig='nvim ~/.zshrc'
alias edit_zsh='vim ~/.zshrc'
alias edit_zsh_code='code -r ~/.zshrc'
alias edit_zsh_insiders='code-insiders -r ~/.zshrc'
alias vim_rc='vim ~/.vimrc'
alias edit_host='sudo nano /etc/hosts'
alias edit_nano='nano ~/.nanorc'
alias vim_install='vim +PluginInstall +qall'
alias vim='nvim'
alias vi='vim'
alias nano='micro'

########## PROCESS MANAGEMENT ##########
alias process='ps aux'
alias process_user='ps -u $USER'
alias psa='ps -ef'
alias psf='ps auxf'

########## SYSTEM COMMANDS ##########
alias grep='grep --color=auto'
alias rm='rm -i'
alias h='history'
alias du='du -h'
alias df='df -h'
alias which='type -a'
alias c='clear'
alias free='free -m'

########## TMUX ##########
alias tmux_new='tmux new -s'
alias tmux_attach='tmux a -t'
alias tmux_list='tmux ls'
alias tmux_kill='tmux kill-session -t'
alias tmux_kill_all='pkill -f tmux'

########## UTILITIES ##########
alias reload='source $HOME/.config/zsh/.zshrc'
alias update='sudo pacman -Syu'
alias lt='ls --human-readable --size -1 -S --classify'
alias ghist='history | grep'
alias count='find . -type f | wc -l'
alias cpv='rsync -ah --info=progress2'
alias restart_shell='exec ${SHELL} -l'
alias path='echo -e ${PATH//:/\\n}'
alias j='jobs -l'
alias stats='zsh_stats'
alias mount='mount | column -t'

########## NETWORK ##########
alias ping='ping -c 5'
alias wget='wget -c'
alias ports='netstat -tulanp'
alias myip='curl ifconfig.me && echo'

########## LOCAL HEP ##########
alias mount_gpu='sshfs melashri@gpu:~/inference-engine $HOME/projects/lhcb/inference-engine -o reconnect,ServerAliveInterval=15,ServerAliveCountMax=3,cache=no,uid=$(id -u),gid=$(id -g)'

########## MISC ##########
alias weather_cincy='curl https://wttr.in/Cincinnati | head -7'
alias weather_home='curl https://wttr.in/Al+Mansurah,+Egypt | head -7'
alias weather_cern='curl https://wttr.in/Geneva | head -7'
alias emergency='gh emergency'
alias depressed='gh emergency'
alias tired='gh emergency'

##################################

