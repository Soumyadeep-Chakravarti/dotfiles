##################################
# NEOVIM SWITCHER
##################################

# Aliases for launching Neovim with specific configs
alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"
alias nvim-kick="NVIM_APPNAME=kickstart nvim"
alias nvim-chad="NVIM_APPNAME=NvChad nvim"
alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"
alias nvim-notes="NVIM_APPNAME=NoteVim nvim"

# FZF-based Neovim config selector
function nvims() {
  local items=("default" "kickstart" "LazyVim" "NvChad" "AstroNvim" "NoteVim")
  
  # Use fzf to select a configuration
  local config
  config=$(printf "%s\n" "${items[@]}" | fzf \
    --prompt=" Neovim Config  " \
    --height=50% --layout=reverse --border --exit-0)
  
  # Handle no selection
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  fi

  # Default config maps to empty NVIM_APPNAME
  [[ $config == "default" ]] && config=""

  NVIM_APPNAME="$config" nvim "$@"
}

# Bind Ctrl+a to open the Neovim switcher
bindkey -s "^a" "nvims\n"

