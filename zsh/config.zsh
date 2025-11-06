# =====================================
# ZSH / Shell Environment Configuration
# =====================================

# Enable extended globbing for advanced patterns
setopt extended_glob

# ============================
# CUDA & NVIDIA Toolkit (PATHS)
# ============================
export CUDA_HOME=/opt/cuda
export PATH="${CUDA_HOME}/bin:${PATH}"
export LD_LIBRARY_PATH="${CUDA_HOME}/lib64:${LD_LIBRARY_PATH}"

# ============================
# Java & Android SDK (PATHS)
# ============================
export JAVA_HOME=/usr/lib/jvm/java-25-openjdk
export ANDROID_HOME=/opt/android-sdk
export ANDROID_SDK_ROOT=/opt/android-sdk

# ============================
# AI/ML Tools (PATHS)
# ============================
export PATH="$PATH:$HOME/.cache/lm-studio/bin"

# ============================
# Chrome executable (CONFIG)
# ============================
export CHROME_EXECUTABLE=/usr/bin/chromium

# ============================
# Nix Config (CONFIG)
# ============================
export NIX_CONFIG="experimental-features = nix-command flakes"

# ============================
# PATH: Clean, System-First Order
# ============================

# 1. Start clean — system binaries first (ensures Arch-provided Python, Wine, etc.)
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# 2. CUDA (GPU compute tools)
export PATH="${CUDA_HOME}/bin:${PATH}"
export LD_LIBRARY_PATH="${CUDA_HOME}/lib64:${LD_LIBRARY_PATH}"

# 3. Development tools (Rust, user binaries, etc.)
export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$HOME/bin:$PATH"

# 4. Flutter, Android SDK, Java
export PATH="$HOME/flutter/bin:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$JAVA_HOME/bin:$PATH"

# 5. AI/ML & Custom tools (keep after dev)
export PATH="$PATH:$HOME/.cache/lm-studio/bin"

# ============================
# Homebrew (Optional / Manual Use)
# ============================
# Homebrew binaries are excluded by default for system stability.
# To temporarily use them, run:
#   PATH="/home/linuxbrew/.linuxbrew/bin:$PATH" command
# Or define a quick alias:
#   alias usebrew='export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"'

# ============================
# Verification Commands
# ============================
# To verify Python order:
#   which python3
#   python3 --version
#
# To verify CUDA path:
#   nvcc --version
#
# To verify environment path:
#   echo $PATH | tr ':' '\n'

export WINEPREFIX=/mnt/storage/games/wineprefixes/common
