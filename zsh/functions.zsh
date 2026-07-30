##################################
# SURGICAL FUNCTIONS.ZSH
##################################

########## DEVELOPMENT ##########

# Compile and run a C++ file in ./build
crun() {
    local file=$1
    mkdir -p build
    g++ "$file.cpp" -std=c++17 -o "build/$file.out" && ./build/"$file.out"
}

# Create and push a GitHub repo via CLI
create_and_push_repo() {
    if ! command -v gh &> /dev/null; then
        echo "GitHub CLI not installed"
        return 1
    fi
    local repo_name=$1
    local privacy_flag="--public"
    [[ "$2" == "--private" ]] && privacy_flag="--private"

    git init && git add . && git commit -m "Initial commit"
    gh repo create "$repo_name" $privacy_flag --disable-wiki --disable-issues --source=. --remote=origin --push
}

########## SYSTEM ##########

# Universal extraction tool
extract() {
    if [[ ! -f $1 ]]; then echo "'$1' is not a valid file"; return 1; fi
    case $1 in
        *.tar.bz2) tar xjf "$1" ;;
        *.tar.gz)  tar xzf "$1" ;;
        *.zip)     unzip "$1" ;;
        *.7z)      7z x "$1" ;;
        *)         echo "'$1' cannot be extracted via extract()" ;;
    esac
}

# Make a directory and enter it
mkd() { mkdir -p "$@" && cd "$_"; }
