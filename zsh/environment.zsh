# --- Existing Environment Stuff ---
# ... (all your previous paths and exports)

# --- Your Recent Additions ---
export PATH="$HOME/.npm-global/bin:$PATH"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Java
export JAVA_HOME=/usr/lib/jvm/java-26-openjdk
export PATH="$JAVA_HOME/bin:$PATH"

# Google Cloud SDK
[[ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]] && source "$HOME/google-cloud-sdk/path.zsh.inc"
[[ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]] && source "$HOME/google-cloud-sdk/completion.zsh.inc"

# --- Plugin Hooks ---
# (Keep these in environment or config.zsh, as long as they aren't sourced redundantly)
eval "$(direnv hook zsh)"
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Ensure PATH is unique and remove duplicates
typeset -U path
export PATH
