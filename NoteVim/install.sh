#!/bin/bash

# Ethan Gilles
# 11/17/24
# Updated for Arch compatibility
# Installs dependencies for NeoVim config

set -e

echo "You will be installing:"
echo "            - curl and wget"
echo "            - Rust"
echo "            - NodeJS"
echo "            - Python3 and pip3"
echo "            - Neovim"
echo "            - JetBrainsMono Nerd Font"
echo "            - CLI Utils"
echo "            - Zathura (with Catppuccin)"
echo "            - LaTeX dependencies"
echo ""
read -p "Enter (yes/no) to confirm installing the items listed: " input

input=$(echo "$input" | tr '[:upper:]' '[:lower:]')

if [[ "$input" != "yes" && "$input" != "y" ]]; then
  echo "Exiting."
  exit 0
fi

# Detect distro
if command -v apt &> /dev/null; then
  DISTRO="debian"
elif command -v pacman &> /dev/null; then
  DISTRO="arch"
else
  echo "Unsupported distro. Exiting."
  exit 1
fi

# Update system
if [[ "$DISTRO" == "debian" ]]; then
  sudo apt update -y && sudo apt upgrade -y
elif [[ "$DISTRO" == "arch" ]]; then
  sudo pacman -Syu --noconfirm
fi

echo ""
echo "-- INSTALLING BASE UTILITIES (curl, wget, zip, unzip) --"
if [[ "$DISTRO" == "debian" ]]; then
  sudo apt install -y -q curl wget zip unzip
else
  sudo pacman -S --noconfirm curl wget zip unzip
fi

echo ""
echo "-- INSTALLING RUST --"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
. "$HOME/.cargo/env"

echo ""
echo "-- INSTALLING PYTHON3 AND PIP3 --"
if [[ "$DISTRO" == "debian" ]]; then
  sudo apt install -y -q python3 python3-pip python3-venv
else
  sudo pacman -S --noconfirm python python-pip python-virtualenv
fi
echo "alias python='python3'" >> "$HOME/.bashrc"
pip3 install --user --upgrade neovim

echo ""
echo "-- INSTALLING NODEJS (via FNM) --"
curl -fsSL https://fnm.vercel.app/install | bash

export FNM_DIR="$HOME/.local/share/fnm"
export PATH="$FNM_DIR:$PATH"
eval "`$FNM_DIR/fnm env`"

fnm install 20
fnm default 20

npm install --global yarn
npm install -g neovim

echo ""
echo "-- INSTALLING JETBRAINS MONO NERD FONT --"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
FONT_DIR="$HOME/.local/share/fonts"

mkdir -p "$FONT_DIR"
cd "$FONT_DIR"
curl -OL "$FONT_URL"
unzip JetBrainsMono.zip && rm JetBrainsMono.zip
fc-cache -fv

cd "$HOME"

echo ""
echo "-- INSTALLING NEOVIM --"
if [[ "$DISTRO" == "debian" ]]; then
  sudo apt install -y libfuse2 fuse
elif [[ "$DISTRO" == "arch" ]]; then
  sudo pacman -S --noconfirm fuse2
fi

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod +x nvim-linux-x86_64.appimage
sudo mkdir -p /opt/nvim
sudo mv nvim-linux-x86_64.appimage /opt/nvim/nvim
echo "export PATH=\"\$PATH:/opt/nvim\"" >> "$HOME/.bashrc"
echo "alias vim='nvim'" >> "$HOME/.bashrc"

echo ""
echo "-- INSTALLING CLI UTILITIES --"
if [[ "$DISTRO" == "debian" ]]; then
  sudo apt install -y -q ripgrep fd-find xclip
else
  sudo pacman -S --noconfirm ripgrep fd xclip
fi

echo ""
echo "-- INSTALLING LATEX & ZATHURA --"
if [[ "$DISTRO" == "debian" ]]; then
  sudo apt install -y -q zathura texlive-full
else
  sudo pacman -S --noconfirm zathura zathura-pdf-mupdf texlive-most
fi

cargo install tree-sitter-cli

# Set up Zathura Catppuccin theme
mkdir -p "$HOME/.config/zathura"
if [ -d "$HOME/.config/nvim/zathura" ]; then
  cp -r "$HOME/.config/nvim/zathura/"* "$HOME/.config/zathura/"
fi

echo ""
echo "✅ Installation complete. NeoVim and dependencies are ready."
exec bash

