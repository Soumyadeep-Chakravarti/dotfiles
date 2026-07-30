# Workstation Audit Report

**Date:** 2026-07-04
**Machine:** Dell G15 5530
**User:** sammy (Soumyadeep Chakravarti)

---

## 1. Executive Summary

A well-organized, multi-purpose development workstation running EndeavourOS (Arch-based) with Hyprland. The system has 1993 packages, 3 distrobox containers, Docker/Podman/QEMU virtualization, and a mature Neovim-based development environment. The user works across AI/ML, physics research (LHCb), Android development, systems programming (C/C++/Rust), and web development.

The workstation is not a random Arch install -- it is an evolving system with clear architecture, modular configuration, and intentional tool selection. The primary gap is not tooling or organization but documentation and reproducibility.

---

## 2. System Overview

| Component | Detail |
|-----------|--------|
| **Distribution** | EndeavourOS (Arch-based), build 2025.03.19 |
| **Kernel** | Linux 7.0.14-zen1-1-zen (Zen kernel) |
| **Bootloader** | systemd-boot 261.1 (UEFI, Secure Boot enabled) |
| **Filesystem** | ext4 on NVMe (443GB, 42% used) |
| **Data Partition** | NTFS at `/mnt/Data` (external or secondary drive) |
| **CPU** | Intel Core i7-13650HX (13th Gen, 14 cores / 20 threads) |
| **GPU** | Intel UHD Graphics + NVIDIA RTX 3050 6GB Laptop (GA107BM) |
| **RAM** | 16GB (8.1GB used, 7.6GB swap) |
| **Display** | eDP-1 1920x1080@120Hz (nwg-displays managed) |
| **Shell** | Zsh 5.9.1 |
| **Terminal** | Kitty (2 instances running) |
| **Window Manager** | Hyprland (with Hyprlock, Hypridle) |
| **Display Manager** | SDDM |

**Notable:** Dual-boot with Windows (Windows Boot Manager in EFI). NVIDIA persistence daemon running. Binderfs configured.

---

## 3. Tool Inventory

### 3.1 Package Managers

| Scope | Tool | Status |
|-------|------|--------|
| System | pacman | Active, 1993 packages |
| AUR | paru v2.1.0 | Active |
| Python | uv 0.11.26 | Active (primary Python tool) |
| Rust | cargo 1.96.0 | Active |
| JavaScript | bun 1.3.14 | Active (primary JS runtime) |
| Node compat | npm 11.18.0 | Active (for projects requiring node) |
| Python CLI tools | pipx 1.15.0 | Active |
| Lua | luarocks 3.13.0 | Installed |
| Cross-platform | brew (linuxbrew) | Legacy, referenced in git credential helper |
| Sandboxed | flatpak | Installed but unused |

**Observations:**
- brew is likely legacy (only referenced in git credential helper path)
- flatpak is installed but has no listed runtimes
- Package managers are scoped by ecosystem, not duplicated

### 3.2 Version Managers

| Manager | Languages | Status |
|---------|-----------|--------|
| **rustup** 1.29.0 | Rust | Active, stable default |

**Rust toolchains:** stable-x86_64-unknown-linux-gnu (default)

**Rust targets:** aarch64-linux-android, aarch64-unknown-linux-gnu, armv7-linux-androideabi, i686-android, wasm32-wasip1, wasm32-wasip2, x86_64-linux-android, x86_64-unknown-linux-gnu

**Not present:** mise, pyenv, nvm/fnm, sdkman, asdf

**Observations:** Android + WASM targets indicate cross-compilation work. Python managed via uv (system Python 3.14.6). Node managed via pacman (LTS Jod 22.23.1).

### 3.3 Language Toolchains

| Language | Compiler/Interpreter | Version | Package Mgr | LSP | Formatter |
|----------|---------------------|---------|-------------|-----|-----------|
| **C** | gcc | 16.1.1 | pacman | clangd (via clang 22.1.6) | clang-format |
| **C++** | g++ | 16.1.1 | pacman | clangd | clang-format |
| **Rust** | rustc | 1.96.0 | rustup/cargo | rustacean.nvim | rustfmt |
| **Python** | python3 | 3.14.6 | pacman/uv | pyright (via Mason) | black, isort |
| **Java** | OpenJDK | 26.0.1 | pacman | -- | -- |
| **Node.js** | node | 22.23.1 (LTS) | pacman | ts_ls (via Mason) | prettierd |
| **Lua** | lua | 5.5.0 | pacman | lua_ls (via Mason) | stylua |
| **Bash** | bash | 5.3.15 | pacman | bashls (via Mason) | -- |

**Notes:**
- gcc15 also installed alongside gcc16 (likely legacy)
- clang 22.1.6, lldb 22.1.6 (LLVM toolchain)
- No Go toolchain installed
- Rust LSP handled by rustacean.nvim instead of Mason-managed rust_analyzer

### 3.4 Development Tools

| Tool | Version | Notes |
|------|---------|-------|
| **git** | 2.55.0 | SSH signing, credential helper via gh |
| **gh** | (installed) | GitHub CLI |
| **ssh** | OpenSSH 10.3 | Ed25519 key |
| **gpg** | 2.4.9 | GnuPG (unused for git, SSH used instead) |
| **cmake** | 4.3.4 | Build system |
| **meson** | (installed) | Build system |
| **ninja** | (installed) | Build system |
| **make** | (installed) | Build system |
| **gdb** | 17.2 | GNU debugger |
| **lldb** | 22.1.6 | LLVM debugger |
| **strace** | 7.0 | System call tracer |

**Build systems:** cmake, meson/ninja, and make are all present for C/C++ development -- not duplication, but coverage of different project build systems.

**Debuggers:** gdb (gcc toolchain) and lldb (clang toolchain) are complementary, not redundant.

### 3.5 Editors & IDEs

| Editor | Version | Config Location | Status |
|--------|---------|-----------------|--------|
| **Neovim** | 0.12.3 | `~/.config/nvim/` | Primary editor |
| **VS Code Insiders** | (running) | `~/.config/Code - Insiders/` | Active (user service) |
| **Android Studio** | 2026.1.1.10 | system install | Android development |
| **Kate** | (config present) | `~/.config/katevirc` | Secondary/KDE |

**Neovim Plugin Stack (lazy.nvim):**
- LSP: nvim-lspconfig, mason.nvim, mason-lspconfig, mason-tool-installer, fidget
- Completion: blink.cmp, blink.compat, friendly-snippets, blink-emoji, cmp-sql
- Treesitter: nvim-treesitter, nvim-treesitter-textobjects
- Fuzzy finding: fzf-lua
- Navigation: oil.lua, project.lua, project-fzf
- UI: dressing.lua, which-key, statusline, showkeys, kanagawa (colorscheme)
- Language: rustacean.nvim (Rust IDE support)
- Formatting: conform.nvim (stylua, black, isort, rustfmt, prettierd)
- Other: sleuth-vim (auto-detect indent)

**Observations:** Based on Kickstart template. LSP servers active: bashls, marksman, lua_ls. Others (clangd, gopls, pyright, rust_analyzer) commented out -- rust handled by rustacean.nvim.

---

## 4. Git Architecture

| Setting | Value | Notes |
|---------|-------|-------|
| **User** | Soumyadeep Chakravarti | soumyadeepsai1@gmail.com |
| **Signing** | SSH (Ed25519) | `~/.ssh/id_ed25519.pub` |
| **GPG format** | ssh | `gpg.format=ssh` |
| **Commit signing** | Enabled | `commit.gpgsign=true` |
| **Allowed signers** | `~/.ssh/allowed_signers` | SSH signing verification |
| **Credential helper** | gh auth git-credential | GitHub CLI manages tokens |
| **HTTP version** | HTTP/1.1 | Explicit override |

**Observations:**
- Git is configured with SSH signing (not GPG) -- modern, simple, no keyring dependency
- Credential management delegated to gh CLI -- clean, no plaintext tokens
- No global gitignore or git template configured
- No git aliases defined
- No hooks directory visible

---

## 5. SSH & Secrets

### 5.1 SSH

| Item | Detail |
|------|--------|
| **Keys** | `~/.ssh/id_ed25519` (Ed25519) |
| **Config** | No `~/.ssh/config` file |
| **Known hosts** | `~/.ssh/known_hosts` present |
| **Agent** | Not configured (no ssh-agent or keychain visible) |
| **FIDO/U2F** | Not configured |
| **YubiKey** | Not present |

**Observations:** Single Ed25519 key. No SSH config means no host aliases, jump hosts, or custom settings. Agent forwarding not configured.

### 5.2 Secrets Management

| System | Status |
|--------|--------|
| **Bitwarden** | Installed (password manager) |
| **Bitwarden CLI** | Installed (`bitwarden-cli`) |
| **SSH key** | Ed25519, unencrypted (no passphrase prompt observed) |
| **gnome-keyring** | Running (user service) |
| **Git signing** | SSH-based (no GPG key needed) |
| **API keys** | Environment variables in `~/.config/zsh/environment.zsh` |
| **.env files** | Not audited |

**Observations:** Bitwarden + CLI present for password management. gnome-keyring provides credential storage. No visible `.env` files at home root, but environment exports contain paths and credentials (Google Cloud SDK).

---

## 6. Storage & Filesystem

### 6.1 Filesystem Layout

| Mount | Device | Type | Size | Usage |
|-------|--------|------|------|-------|
| `/` | `/dev/nvme0n1p5` | ext4 | 443GB | 42% (177GB used) |
| `/efi` | `/dev/nvme0n1p4` | vfat | -- | EFI system partition |
| `/mnt/Data` | UUID A002B00302AFDD12 | ntfs-3g | -- | Data partition |
| `/tmp` | tmpfs | tmpfs | -- | Temporary |
| `/dev/shm` | tmpfs | tmpfs | 12GB | Shared memory |

### 6.2 Notable Configuration

- `noatime` on root (performance optimization)
- NTFS data partition with uid/gid mapping for user access
- tmpfs on `/dev/shm` with 12GB (half of RAM)
- Binderfs configured (for containers)

### 6.3 Backup Status

| Tool | Status |
|------|--------|
| **Timeshift** | Not installed |
| **Btrfs snapshots** | Not applicable (ext4) |
| **borg** | Installed |
| **~/scripts/backup.sh** | Exists, purpose confirmed |
| **~/scripts/setup-backup-drive.sh** | Exists |
| **~/scripts/sync-docs.sh** | Exists |

**Observations:** borg is installed for deduplicated backups. Manual backup scripts exist. No automated scheduling visible. No external backup target confirmed.

---

## 7. Development Workflow

### 7.1 Primary Workflow Patterns

**AI/ML Development:**
- Distrobox container (ai-dev, Fedora) for isolated environments
- `ai` alias to enter, `ai-run` for background commands
- SSH mount to GPU server (`mount_gpu`) for LHCb inference
- Local LLM via llama.cpp (Qwen2.5-Coder-7B Q4_K_M on port 8080)
- OpenCode AI assistant with MCP servers (obsidian, agent-memory, filesystem, sequential-thinking)

**Physics Research (LHCb):**
- SSH filesystem mount to remote GPU server
- Container-based workflow for reproducibility

**Android Development:**
- Android Studio installed
- Rust cross-compilation targets (aarch64, armv7, i686)
- distrobox container `android-dev` (Ubuntu 24.04)

**Systems Programming (C/C++/Rust):**
- Full toolchain: gcc, clang, gdb, lldb, cmake, meson, ninja
- Rust with cross-compilation (Android, WASM targets)
- rustacean.nvim for Rust IDE support

**Web Development:**
- Node.js 22 LTS, bun, npm
- TypeScript support via Mason (ts_ls)
- prettierd for formatting

### 7.2 Project Structure

```
~/Projects/
  college/          # Academic work
  personal/         # Personal projects
  _templates/       # Project templates

~/dev/              # Additional development directory
~/homelab/          # Homelab configuration
~/scripts/          # Utility scripts
~/skills/           # OpenCode agent skills
~/.agent/           # Agent memory MCP
```

**Utility scripts:**
- `backup.sh`, `newproj.sh`, `record.sh`, `setup-backup-drive.sh`, `sync-docs.sh`, `sys-cleanup.sh`

### 7.3 Container Strategy

| Container | Base Image | Purpose | Status |
|-----------|------------|---------|--------|
| **ai-dev** | Fedora latest | AI/ML development | Exited (5 days ago) |
| **android-dev** | Ubuntu 24.04 | Android development | Exited (3 days ago) |
| **osdev** | Arch Linux | OS development | Exited (6 days ago) |

All containers are stopped -- used on-demand, not persistent.

---

## 8. AI Workflow

### 8.1 Local LLM

| Component | Detail |
|-----------|--------|
| **Server** | llama.cpp on localhost:8080 |
| **Model** | Qwen2.5-Coder-7B Q4_K_M |
| **Interface** | OpenAI-compatible API |
| **Status** | Configured in OpenCode (may not be running) |

### 8.2 OpenCode Configuration

**MCP Servers:**
| Server | Command | Purpose |
|--------|---------|---------|
| **obsidian** | `npx @bitbonsai/mcpvault` | Access Obsidian notes at `~/homelab/Notes/My_Obsidian_notes` |
| **agent-memory** | `node ~/.agent/skills/agent-memory/out/mcp-server/server.js` | Persistent agent memory |
| **filesystem** | `npx @modelcontextprotocol/server-filesystem` | File access |
| **sequential-thinking** | `npx @modelcontextprotocol/server-sequential-thinking` | Reasoning |

**Providers:**
- llama.cpp (local Qwen2.5-Coder-7B)
- OpenRouter (external models)

### 8.3 Remote Infrastructure

```
Laptop
  ├── ai-dev container (local AI/ML)
  ├── android-dev container (Android SDK)
  ├── osdev container (kernel/systems)
  └────> GPU Server (sshfs mount)
           └── LHCb inference engine
```

The `mount_gpu` alias reveals this workstation is part of a larger compute ecosystem. The GPU server is accessed via SSH filesystem mount for inference workloads.

### 8.4 Agent Skills

| Path | Content |
|------|---------|
| `~/.agent/skills/` | Agent memory MCP system |
| `~/skills/` | OpenCode agent skills |
| `~/skills-lock.json` | Skill lock file |
| `~/CLAUDE.md` | Claude Code agent instructions |

---

## 9. Homelab

### 9.1 Directory Structure

```
~/homelab/
  Anime/          # Media
  CSE3010/        # Coursework
  docker/         # Docker configurations
  infra/          # Infrastructure
  Models/         # ML models
  Movies/         # Media
  Music/          # Media
  Notes/          # Obsidian vault (shared with MCP)
```

**Observations:**
- `docker/` suggests Docker Compose or similar configurations
- `infra/` suggests infrastructure-as-code or server configs
- `Notes/` is the Obsidian vault connected to OpenCode via MCP
- `Models/` likely contains local ML models

**Unknowns:** What services run in the homelab? What is in `infra/`? Is there a separate server?

---

## 10. Desktop Environment

### 10.1 Hyprland Configuration

Modular architecture with documentation:

```
~/.config/hypr/
  hyprland.conf         # Entry point, source chain
  core/                 # Variables, env, compositor, misc
  display/              # Monitors, workspaces
  input/                # Keyboard, mouse, touchpad, gestures
  appearance/           # Colors, decoration, animations, blur, cursor
  bindings/             # Keybindings by category
  rules/                # Window rules, floating, opacity, layers
  services/             # Startup, daemons
  local/                # User overrides (not tracked)
  scripts/              # Organized by subsystem (10 directories)
  docs/                 # Documentation (Architecture, Keybinds, Themes, etc.)
```

**Theme:** Wallust for dynamic wallpaper-based colors. Kanagawa for Neovim.

### 10.2 Key Applications

| App | Config Location | Purpose |
|-----|-----------------|---------|
| **Kitty** | `~/.config/kitty/` | Terminal (Japanesque theme, FantasqueSansM Nerd Font, 16pt) |
| **Waybar** | `~/.config/waybar/` | Status bar (multiple styles) |
| **Rofi** | `~/.config/rofi/` | Application launcher (10+ configs) |
| **Swaync** | `~/.config/swaync/` | Notification daemon |
| **Wlogout** | `~/.config/wlogout/` | Logout menu |
| **Zellij** | `~/.config/zellij/` | Terminal multiplexer (auto-starts) |
| **Obsidian** | `~/.config/obsidian/` | Note taking |
| **qBittorrent** | `~/.config/qBittorrent/` | Torrent client |
| **mpv** | `~/.config/mpv/` | Media player |
| **zathura** | `~/.config/zathura/` | PDF viewer |
| **qutebrowser** | `~/.config/qutebrowser/` | Vim-style browser |
| **Chromium** | (config present) | Web browser |
| **Bitwarden** | `~/.config/Bitwarden/` | Password manager |
| **btop** | `~/.config/btop/` | System monitor |
| **easyeffects** | `~/.config/easyeffects/` | Audio effects/EQ |
| **Element** | `~/.config/Element/` | Matrix chat |
| **Discord** | `~/.config/discord/` | Communication |
| **Spotify** | `~/.config/spotify/` | Music streaming |

**Browser workflow:** qutebrowser (daily driver, vim-style), Chromium (development/testing).

---

## 11. Services

### 11.1 System Services

| Service | Purpose |
|---------|---------|
| **docker** | Container engine |
| **containerd** | Container runtime |
| **NetworkManager** | Network management |
| **systemd-resolved** | DNS resolution |
| **bluetooth** | Bluetooth stack |
| **sddm** | Display manager |
| **nvidia-persistenced** | NVIDIA GPU persistence |
| **polkit** | Authorization |
| **power-profiles-daemon** | Power management |
| **chronyd** | NTP time sync |
| **auditd** | Security audit logging |
| **keyd** | Key remapping daemon |
| **nohang-desktop** | Low memory handler |
| **udisks2** | Disk management |
| **upower** | Power management |
| **tailscaled** | Tailscale VPN mesh |
| **proton.VPN** | Proton VPN |
| **virtnetworkd** | libvirt networking |
| **smb/nmb** | Samba file sharing |
| **rtkit-daemon** | Realtime scheduling |

### 11.2 User Services

| Service | Purpose |
|---------|---------|
| **pipewire/pulse** | Audio |
| **wireplumber** | Audio session management |
| **swaync** | Notifications |
| **xdg-desktop-portal-hyprland** | Wayland portal |
| **xdg-desktop-portal-gtk** | GTK portal |
| **gnome-keyring-daemon** | Credential storage |
| **gvfs-*** | Virtual filesystem (MTP, UDisks2) |
| **playerctld** | Media player control |

---

## 12. Technical Debt

### 12.1 Actual Debt

| Area | Issue | Severity |
|------|-------|----------|
| **Zsh backups** | 5 backup files (`~/.zshrc-backup*`, `~/.zshrc.bak`, `~/.config/zsh_old/`) | Low |
| **Home clutter** | `~/package.json`, `~/pyvenv.cfg`, `~/bun.lock`, `~/imgui.ini` at root | Low |
| **Legacy brew** | Linuxbrew referenced in git credential helper | Low |
| **Unused flatpak** | Installed but no runtimes | Low |
| **gcc15** | Installed alongside gcc16 | Low |
| **qemu-full + qemu-base** | Redundant (full includes base) | Low |
| **VPN overlap** | Tailscale + Proton VPN both running | Medium |
| **Package inventory files** | 10+ `*_list.txt` files at home root | Low |

### 12.2 Not Debt (Intentional Design)

| Item | Why it exists |
|------|---------------|
| **pacman + paru + uv + cargo + bun + npm** | Scoped by ecosystem, not duplicated |
| **cmake + meson + ninja + make** | C/C++ projects use different build systems |
| **gdb + lldb** | GNU vs LLVM debugger (complementary) |
| **node + bun** | bun primary, node for compatibility |
| **No Python version manager** | uv manages Python projects; system Python sufficient |
| **No Nix/Home Manager** | Design choice, not deficiency |

---

## 13. Strengths

1. **Clear architecture** -- Workstation has structure, not chaos
2. **Modular Hyprland config** -- Separation of concerns with documentation
3. **Modern Python tooling** -- uv is fast and correct
4. **Rust cross-compilation** -- Android + WASM targets configured
5. **Shell architecture** -- Modular zsh with Starship, zoxide, atuin, fzf
6. **Neovim setup** -- Clean lazy.nvim with blink.cmp, conform.nvim, treesitter
7. **Container strategy** -- Distrobox for isolated environments
8. **Git security** -- SSH signing, gh credential helper
9. **Audio** -- PipeWire + easyeffects
10. **Documentation** -- Hyprland config has architecture docs
11. **Ecosystem integration** -- GPU server mount, homelab, agent skills

---

## 14. Risks

### Priority 1: No automated workstation rebuild
If the laptop fails, there is no single script or manifest to restore the environment. Backup scripts exist but no full rebuild automation.

### Priority 2: Backup automation
borg is installed, backup scripts exist, but no automated scheduling or confirmed backup target.

### Priority 3: No central workstation repository
Configuration is scattered across `~/.config/`, `~/scripts/`, `~/homelab/`, `~/skills/`. No single repository ties them together.

### Priority 4: Knowledge in head
The user clearly knows how everything works. The documentation should make it possible for future self or someone else to rebuild without relying on memory.

### Priority 5: 16GB RAM
May limit AI/ML workloads and multiple containers simultaneously.

---

## 15. Questions / Unknowns

1. What does `keyd` remap? Custom keyboard layout?
2. Is the Samba file sharing actively used? To which devices?
3. What services run in `~/homelab/docker/` and `~/homelab/infra/`?
4. How often is `mount_gpu` used for LHCb inference?
5. Are the distrobox containers still actively needed?
6. Is the Proton VPN + Tailscale combination intentional?
7. What templates exist in `~/Projects/_templates/`?
8. What is in `~/Android/`? SDK or AOSP source?
9. Is borg configured with automated backups? What is the target?
10. What does the `keyd` daemon remap?

---

## 16. Recommended Next Steps

Not redesign. Not bootstrap scripts. Capture and automate what already exists.

### Step 1: Create a workstation repository

```
workstation/
  README.md
  docs/
    Architecture.md
    Workflows.md
    Containers.md
    AI.md
    Networking.md
    Recovery.md
    Decisions.md
  manifests/
  bootstrap/
  configs/
  tests/
  scripts/
```

### Step 2: Document decisions

Every architectural choice gets two or three paragraphs explaining why:
- Why uv instead of Poetry?
- Why Bun instead of Deno?
- Why Rustup instead of Mise?
- Why Hyprland instead of something else?
- Why SSH signing instead of GPG?

Six months from now, this will be invaluable.

### Step 3: Create manifests

- `manifests/pacman.txt` -- System packages
- `manifests/aur.txt` -- AUR packages
- `manifests/pip.txt` -- Python packages (via uv pip freeze)
- `manifests/cargo.txt` -- Rust tools (via cargo install --list)
- `manifests/npm.txt` -- Global npm packages
- `manifests/bun.txt` -- Global bun packages

### Step 4: Bootstrap script

A single script that reads manifests and installs everything. Not a replacement for documentation -- a complement to it.

---

## 17. Appendix

### A. Neovim Plugins

| Plugin | Purpose |
|--------|---------|
| blink.cmp | Completion engine |
| blink.compat | Compatibility layer |
| conform.nvim | Formatting |
| dressing.nvim | UI for inputs/selects |
| fzf-lua | Fuzzy finding |
| kanagawa.nvim | Colorscheme |
| nvim-lspconfig | LSP configuration |
| nvim-treesitter | Syntax highlighting |
| nvim-treesitter-textobjects | Treesitter text objects |
| oil.lua | File explorer |
| project.lua | Project management |
| project-fzf | Project fuzzy finding |
| rustacean.nvim | Rust support |
| showkeys.lua | Show keypresses |
| sleuth.vim | Auto-detect indent |
| which-key.lua | Key binding hints |

### B. Rofi Configs

| File | Purpose |
|------|---------|
| config.rasi | Main config |
| config-Animations.rasi | Animation selector |
| config-calc.rasi | Calculator |
| config-clipboard.rasi | Clipboard manager |
| config-edit.rasi | Editor selector |
| config-emoji.rasi | Emoji picker |
| config-keybinds.rasi | Keybind viewer |
| config-kitty-theme.rasi | Kitty theme selector |
| config-Monitors.rasi | Monitor profiles |
| 0-shared-fonts.rasi | Shared font config |

### C. Waybar Styles

Catppuccin (Mocha, Frappe, Latte), Golden Noir, Monochrome, Chroma Glow, Translucent, and more.

### D. Zsh Functions

| Function | Purpose |
|----------|---------|
| `crun` | Compile and run C++ file in ./build |
| `create_and_push_repo` | Create and push GitHub repo via gh CLI |
| `extract` | Universal archive extraction |
