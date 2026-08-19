# Create a directory and enter it
mkcd() {
    mkdir -p -- "$1" && cd -- "$1"
}

# Extract common archive formats
extract() {
    if [[ ! -f "$1" ]]; then
        echo "extract: '$1' is not a file"
        return 1
    fi

    case "$1" in
        *.tar.gz|*.tgz) tar -xzf "$1" ;;
        *.tar.bz2|*.tbz2) tar -xjf "$1" ;;
        *.tar.xz|*.txz) tar -xJf "$1" ;;
        *.tar) tar -xf "$1" ;;
        *.zip) unzip "$1" ;;
        *.7z) 7z x "$1" ;;
        *.rar) unrar x "$1" ;;
        *) echo "extract: unknown archive format: $1"; return 1 ;;
    esac
}
