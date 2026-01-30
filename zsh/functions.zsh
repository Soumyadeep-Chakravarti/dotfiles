# ============================
# FUNCTIONS.ZSH
# ============================

########## DEVELOPMENT ##########

# Bash into a running Docker container
d_bash() {
    if ! command -v docker &> /dev/null; then
        echo "docker not installed"
        return 1
    fi
    docker exec -it $(docker ps -aqf "name=$1") bash
}

# Compile and run a C++ file in ./build
crun() {
    local file=$1
    mkdir -p build
    g++ "$file.cpp" -std=c++17 -o "build/$file.out" && ./build/"$file.out"
}

# Go to the root of the current git repo
git_root() {
    cd "$(git rev-parse --show-toplevel)" || return
}

# Search git log for introduction of string $1 in file $2
git_search() {
    git log -S "$1" --source --all "$2"
}

# Search for pattern $2 in folder $1 recursively
grepfind() {
    grep -rnw "$1" -e "$2"
}

# Create and push a GitHub repo via CLI
create_and_push_repo() {
    if ! command -v gh &> /dev/null; then
        echo "GitHub CLI not installed"
        return 1
    fi
    if [[ -z $1 ]]; then
        echo "Usage: create_and_push_repo <repo-name> [--private]"
        return 1
    fi

    local repo_name=$1
    local privacy_flag="--public"
    [[ "$2" == "--private" ]] && privacy_flag="--private"

    git init || return 1
    git add . || return 1
    git commit -m "Initial commit" || return 1
    gh repo create "$repo_name" $privacy_flag --disable-wiki --disable-issues --source=. --remote=origin --push || return 1
    echo "Repository $repo_name created and pushed successfully!"
}

update_dotfiles() {
    # Absolute path to your dotfiles repo
    local DOTFILES_DIR="$HOME/.config"

    # Prompt for confirmation
    read "confirm?⚠️ This will destroy the git history in $DOTFILES_DIR and force push! Continue? (y/N): "
    [[ $confirm != [yY] ]] && echo "Aborted." && return

    # Backup current .git just in case
    if [[ -d "$DOTFILES_DIR/.git" ]]; then
        local backup=".git_backup_$(date +%s)"
        mv "$DOTFILES_DIR/.git" "$DOTFILES_DIR/$backup"
        echo "⚠️ .git backed up to $DOTFILES_DIR/$backup"
    fi

    # Reset repo
    rm -rf "$DOTFILES_DIR/.git"
    git -C "$DOTFILES_DIR" init
    git -C "$DOTFILES_DIR" add .
    git -C "$DOTFILES_DIR" commit -m "Clean dotfiles: allow-list only"
    git -C "$DOTFILES_DIR" branch -M main

    # Set remote (replace with your own repo if different)
    git -C "$DOTFILES_DIR" remote add origin git@github.com:Soumyadeep-Chakravarti/dotfiles.git

    # Force push
    git -C "$DOTFILES_DIR" push -f origin main
    echo "✅ Dotfiles in $DOTFILES_DIR updated."
}

########## SYSTEM ##########

# Move files to trash
trash() { command mv "$@" "$HOME/.Trash"; }

# Create a ZIP archive of a folder
zipf() { zip -r "$1".zip "$1"; }

# Extract most archive formats
extract() {
    if [[ ! -f $1 ]]; then
        echo "'$1' is not a valid file"
        return 1
    fi
    case $1 in
        *.tar.bz2) tar xjf "$1" ;;
        *.tar.gz)  tar xzf "$1" ;;
        *.bz2)     bunzip2 "$1" ;;
        *.rar)     unrar e "$1" ;;
        *.gz)      gunzip "$1" ;;
        *.tar)     tar xf "$1" ;;
        *.tbz2)    tar xjf "$1" ;;
        *.tgz)     tar xzf "$1" ;;
        *.zip)     unzip "$1" ;;
        *.Z)       uncompress "$1" ;;
        *.7z)      7z x "$1" ;;
        *)         echo "'$1' cannot be extracted via extract()" ;;
    esac
}

########## EXTERNAL COMMANDS ##########

# Upload files to transfer.sh
transfer() {
    if ! command -v curl &> /dev/null; then
        echo "curl not installed"
        return 1
    fi

    local files=("$@")
    if [[ -z "${files[*]}" ]]; then
        echo "Usage: transfer <file1> [file2 ...]"
        return 1
    fi

    du -L "${files[@]}"
    read -r "confirm?Upload ${#files[@]} file(s)? (y/n): "
    [[ "$confirm" != [yY] ]] && return 1

    for f in "${files[@]}"; do
        if [[ ! -f $f ]]; then
            echo "'$f' not found"
            continue
        fi
        local output
        output=$(curl --request PUT --progress-bar --dump-header - --upload-file "$f" "https://tr.melashri.eu.org/")
        echo "$output" | awk '
            BEGIN {IGNORECASE=1}
            /x-url-delete/ {print "Delete command: curl -X DELETE "$2; print "Delete token: "$2}
            END {print "Download link: "$0}'
    done
}

########## OS HELPERS ##########

# Display host info
ii() {
    echo -e "\nHostname: $HOSTNAME"
    echo "System info: $(uname -a)"
    echo "Users: $(w -h)"
    echo "Date: $(date)"
    echo "Uptime: $(uptime)"
    echo "Network: $(scselect)"
    echo "Public IP: $(myip)"
}

# Find files by exact name
fff() { find . -name "$1"; }

# Find files starting with prefix
ffs() { find . -name "$1*"; }

# Find files ending with suffix
ffe() { find . -name "*$1"; }

# Cross-platform open
if [[ "$(uname -s)" != "Darwin" ]]; then
    if grep -q Microsoft /proc/version; then
        alias open='explorer.exe'
    else
        alias open='xdg-open'
    fi
fi

# Make a directory and enter it
mkd() { mkdir -p "$@" && cd "$_"; }

# Get size of file/folder
get_size() {
    local path="$1"
    [[ ! -e $path ]] && echo "Error: $path not found" && return 1
    local size=$(du -sb "$path" | awk '{print $1}')
    if [[ $size -ge 1073741824 ]]; then
        echo "$path: $(bc <<< "scale=2; $size/1073741824") GB"
    else
        echo "$path: $(bc <<< "scale=2; $size/1048576") MB"
    fi
}

########## DOCKER ##########

d_alias() {
    alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/" | sed "s/['|\']//g" | sort
}

d_ip() {
    for c in "$@"; do
        docker inspect -f "{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}" "$c"
    done
}

d_stats() {
    if [[ -z $1 ]]; then
        docker stats --no-stream --format 'table {{.Name}}\t{{.CPUPerc}}\t{{.MemPerc}}\t{{.MemUsage}}\t{{.NetIO}}\t{{.PIDs}}'
    else
        docker stats --no-stream --format 'table {{.Name}}\t{{.CPUPerc}}\t{{.MemPerc}}\t{{.MemUsage}}\t{{.NetIO}}\t{{.PIDs}}' | grep "$1"
    fi
}

d_stop() {
    local targets=("$@")
    if [[ ${#targets[@]} -eq 0 ]]; then
        docker stop $(docker ps -aq)
    else
        for c in "${targets[@]}"; do
            docker stop $(docker ps -aq | grep "$c")
        done
    fi
}

d_rm() {
    local targets=("$@")
    if [[ ${#targets[@]} -eq 0 ]]; then
        docker rm $(docker ps -aq)
    else
        for c in "${targets[@]}"; do
            docker rm $(docker ps -aq | grep "$c")
        done
    fi
}

d_rmi() {
    local targets=("$@")
    if [[ ${#targets[@]} -eq 0 ]]; then
        docker rmi $(docker images --filter 'dangling=true' -aq)
    else
        for c in "${targets[@]}"; do
            docker rmi $(docker images --filter 'dangling=true' -aq | grep "$c")
        done
    fi
}

########## MISC ##########

# Fetch cheat.sh
cheat() { curl "https://cheat.sh/$1"; }

# ===============================
# Kitty Cheat Sheet Command
# ===============================
kitty_cheats() {
    cat <<'EOF'

==============================
💫 Kitty Shortcuts - Homelab Workflow
==============================

▶ Pane Focus
Ctrl + Alt + Left   → Focus left
Ctrl + Alt + Right  → Focus right
Ctrl + Alt + Up     → Focus up
Ctrl + Alt + Down   → Focus down

▶ Pane Resize
Ctrl + Alt + Shift + Left   → Resize left
Ctrl + Alt + Shift + Right  → Resize right
Ctrl + Alt + Shift + Up     → Resize up
Ctrl + Alt + Shift + Down   → Resize down

▶ Quick Project Panes
Ctrl + Alt + H   → Launch Homelab (~/homelab)
Ctrl + Alt + C   → Launch Coding (~/projects)
Ctrl + Alt + T   → Launch Scratchpad (~/scratch)

▶ Themes (Optional)
Ctrl + Alt + D   → Day mode (if configured)
Ctrl + Alt + N   → Night mode (if configured)

▶ General
Ctrl + Shift + T → New tab
Ctrl + Shift + W → Close tab
Ctrl + Shift + Left/Right → Switch tabs

▶ Notes
    - Scratchpad auto-created at ~/scratch
    - Default shell is $SHELL
    - All keybindings can be found / modified in ~/.config/kitty/kitty.conf

==============================

EOF
}

# Optional alias
alias khelp="kitty_cheats"


# Top 10 commands by frequency
cmd() {
    history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' \
        | grep -v "./" | column -c3 -s " " -t | sort -nr | nl | head -n10
}

# List all aliases and functions
list_commands() {
    echo "User-defined Aliases:"; alias
    echo; echo "User-defined Functions:"
    typeset -f | awk '/^[a-zA-Z0-9]/ {print $1}'
}

########## PHYSICS ##########

export PHYSICS_ROOT="$HOME/physics"

activate-physics() {
    echo "Activating Physics Environment..."
    source "$PHYSICS_ROOT/venv-physics/bin/activate"

    export PATH="$PHYSICS_ROOT/fastjet/bin:$PATH"
    export LD_LIBRARY_PATH="$PHYSICS_ROOT/fastjet/lib:$LD_LIBRARY_PATH"
    export PKG_CONFIG_PATH="$PHYSICS_ROOT/fastjet/lib/pkgconfig:$PKG_CONFIG_PATH"

    export PYTHIA8="$PHYSICS_ROOT/pythia"
    export PATH="$PYTHIA8/bin:$PATH"
    export LD_LIBRARY_PATH="$PYTHIA8/lib:$LD_LIBRARY_PATH"
    export PYTHONPATH="$PYTHIA8/lib:$PYTHONPATH"

    export ROOTSYS="$PHYSICS_ROOT/ROOT"
    export PATH="$ROOTSYS/bin:$PATH"
    export LD_LIBRARY_PATH="$ROOTSYS/lib:$LD_LIBRARY_PATH"
    export PYTHONPATH="$ROOTSYS/lib:$PYTHONPATH"

    echo "Physics Environment Ready."
}

