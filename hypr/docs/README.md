# Hyprland Configuration

Modular, maintainable Hyprland configuration built on JaKooLit dots v2.3.20.

## Architecture

```
hyprland.conf          # Entry point - sources all modules
│
├── core/              # Global variables, env vars, compositor settings
│   ├── variables.conf   # $mainMod, $term, $files, paths
│   ├── environment.conf # NVIDIA, Wayland, Qt, cursor env vars
│   ├── compositor.conf  # Dwindle, Master, XWayland, cursor, render
│   └── misc.conf        # Logo, VRR, swallow, ANR, fullscreen focus
│
├── display/           # Monitor and workspace configuration
│   ├── monitors.conf    # Output definitions (nwg-displays managed)
│   └── workspaces.conf  # Workspace rules and assignments
│
├── input/             # Input device configuration
│   ├── keyboard.conf    # Layout, repeat rate
│   ├── mouse.conf       # Sensitivity, focus-follow
│   ├── touchpad.conf    # Natural scroll, tap-to-click
│   └── gestures.conf    # 3/4-finger gestures
│
├── appearance/        # Visual configuration
│   ├── colors.conf      # Wallust dynamic colors
│   ├── decoration.conf  # Borders, gaps, opacity, shadow
│   ├── animations.conf  # Transition curves and timing
│   ├── blur.conf        # Background blur settings
│   └── cursor.conf      # Cursor theme and behavior
│
├── bindings/          # Keybindings by category
│   ├── applications.conf # App launchers (terminal, rofi, browser)
│   ├── windows.conf      # Window management (close, float, resize, groups)
│   ├── workspaces.conf   # Workspace switching and movement
│   ├── media.conf        # Volume, brightness, media keys
│   ├── screenshots.conf  # Screenshot keybinds
│   └── custom.conf       # User features and system shortcuts
│
├── rules/             # Window and layer rules
│   ├── windows.conf     # App categorization tags
│   ├── floating.conf    # Float rules and named windows
│   ├── opacity.conf     # Per-category opacity
│   ├── layers.conf      # Wayland layer rules (rofi, notifications)
│   └── workspaces.conf  # Workspace-specific rules
│
├── services/          # Startup and defaults
│   ├── startup.conf     # exec-once services
│   └── daemons.conf     # Default apps, env vars
│
├── local/             # User overrides (not tracked)
│   └── override.conf    # Personal tweaks
│
├── scripts/           # Shell scripts (copied from original)
├── wallust/           # Wallust color generation
├── hyprlock.conf      # Lock screen
├── hypridle.conf      # Idle management
└── wallpaper_effects/ # Wallpaper processing
```

## Key Design Decisions

1. **Single variable source**: All variables defined in `core/variables.conf`
2. **Single responsibility**: Each file handles one concern
3. **No redundancy**: Removed duplicate settings between old configs/ and UserConfigs/
4. **Tag-based rules**: Window rules use Hyprland tags for batch operations
5. **Layered source order**: Core → Display → Input → Appearance → Bindings → Rules → Services → Local

## Customization

- Edit `local/override.conf` for personal tweaks without touching modules
- Edit `core/variables.conf` to change default apps
- Add new keybinds in `bindings/custom.conf`
- Window rules go in `rules/windows.conf`

## Backup

Original config backed up to: `~/.config/hypr.backup-2026-07-04-122020/`

To restore: `rm -rf ~/.config/hypr && mv ~/.config/hypr.backup-YYYY-MM-DD-HHMMSS ~/.config/hypr`
