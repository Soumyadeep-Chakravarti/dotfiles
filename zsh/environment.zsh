# =====================================
# environment.zsh — Environment Variables & Tool Paths
# =====================================

# ----------------------------
# Core PATHs
# ----------------------------
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

# ----------------------------
# Linuxbrew / Homebrew
# ----------------------------
if [[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# ----------------------------
# Go
# ----------------------------
export GOPATH="$HOME/go"
export GOROOT="/home/linuxbrew/.linuxbrew/Cellar/go/1.23.4/libexec"
export PATH="$PATH:$GOROOT/bin:$GOPATH/bin"

# ----------------------------
# Rust
# ----------------------------
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# ----------------------------
# Node.js / NVM
# ----------------------------
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# ----------------------------
# Java / Android SDK
# ----------------------------
export JAVA_HOME="/usr/lib/jvm/java-25-openjdk"
export ANDROID_HOME="/opt/android-sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
[[ -d "$JAVA_HOME/bin" ]] && export PATH="$JAVA_HOME/bin:$PATH"
[[ -d "$ANDROID_HOME/cmdline-tools/latest/bin" ]] && export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
[[ -d "$ANDROID_HOME/platform-tools" ]] && export PATH="$ANDROID_HOME/platform-tools:$PATH"

# ----------------------------
# CUDA / NVIDIA
# ----------------------------
export CUDA_HOME="/opt/cuda"
[[ -d "$CUDA_HOME/bin" ]] && export PATH="$CUDA_HOME/bin:$PATH"
[[ -d "$CUDA_HOME/lib64" ]] && export LD_LIBRARY_PATH="$CUDA_HOME/lib64:${LD_LIBRARY_PATH:-}"

# ----------------------------
# Nix
# ----------------------------
if [[ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]]; then
    source "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi
export NIX_CONFIG="experimental-features = nix-command flakes"

# ----------------------------
# AI / ML Tools
# ----------------------------
[[ -d "$HOME/.cache/lm-studio/bin" ]] && export PATH="$HOME/.cache/lm-studio/bin:$PATH"

# ----------------------------
# Physics Tools (toggle with comments)
# ----------------------------
# export PHYSICS_ROOT="$HOME/physics"
# source "$PHYSICS_ROOT/venv-physics/bin/activate"
# export PYTHIA8="$PHYSICS_ROOT/pythia"
# export PATH="$PYTHIA8/bin:$PATH"
# export LD_LIBRARY_PATH="$PYTHIA8/lib:$LD_LIBRARY_PATH"
# export PYTHONPATH="$PYTHIA8/lib:$PYTHONPATH"
# export ROOTSYS="$PHYSICS_ROOT/ROOT"
# export PATH="$ROOTSYS/bin:$PATH"
# export LD_LIBRARY_PATH="$ROOTSYS/lib:$LD_LIBRARY_PATH"
# export PYTHONPATH="$ROOTSYS/lib:$PYTHONPATH"

# ----------------------------
# Ruby / Gems
# ----------------------------
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

# ----------------------------
# Wine
# ----------------------------
export WINEPREFIX="/mnt/storage/games/wineprefixes/common"

# ----------------------------
# Chrome
# ----------------------------
export CHROME_EXECUTABLE="/usr/bin/chromium"

# ----------------------------
# Custom Scripts
# ----------------------------
export CUSTOM_SCRIPTS="$HOME/scripts"
[[ -d "$CUSTOM_SCRIPTS" ]] && export PATH="$CUSTOM_SCRIPTS:$CUSTOM_SCRIPTS/newproj:$PATH"

# ----------------------------
# Terminal Quran (Optional)
# ----------------------------
if [[ $- == *i* && "$RUN_QURAN_VERSE_ON_STARTUP" == "true" ]]; then
    [[ -f "$HOME/cli/terminal_quran.sh" ]] && source "$HOME/cli/terminal_quran.sh"
fi

# ----------------------------
# PATH Clean-up / System-First
# ----------------------------
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH"

# Direnv integration
if command -v direnv >/dev/null 2>&1; then
    eval "$(direnv hook zsh)"
fi

# ----------------------------
# Verification Commands (Optional)
# ----------------------------
# which python3
# python3 --version
# nvcc --version
# echo $PATH | tr ':' '\n'

