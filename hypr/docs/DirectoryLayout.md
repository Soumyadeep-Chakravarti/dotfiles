# Directory Layout

```
hypr/
├── hyprland.conf              # Entry point - source chain
│
├── core/                      # Global definitions
│   ├── variables.conf         #   $mainMod, $term, $files, paths
│   ├── environment.conf       #   NVIDIA, Wayland, Qt, cursor env vars
│   ├── compositor.conf        #   Dwindle, Master, XWayland, render, cursor
│   └── misc.conf              #   Logo, VRR, swallow, ANR, fullscreen focus
│
├── display/                   # Output configuration
│   ├── monitors.conf          #   Monitor definitions (nwg-displays)
│   └── workspaces.conf        #   Workspace rules and assignments
│
├── input/                     # Input devices
│   ├── keyboard.conf          #   Layout, repeat rate, numlock
│   ├── mouse.conf             #   Sensitivity, acceleration, focus-follow
│   ├── touchpad.conf          #   Natural scroll, tap-to-click, drag lock
│   └── gestures.conf          #   3/4-finger gestures (workspace, zoom, overview)
│
├── appearance/                # Visual configuration
│   ├── colors.conf            #   Wallust dynamic color sourcing
│   ├── decoration.conf        #   Borders, gaps, opacity, shadow, groups
│   ├── animations.conf        #   Bezier curves, animation timing
│   ├── blur.conf              #   Background blur settings
│   └── cursor.conf            #   Cursor theme, hardware cursors
│
├── bindings/                  # Keybindings by category
│   ├── applications.conf      #   App launchers (terminal, rofi, browser, overview)
│   ├── windows.conf           #   Close, fullscreen, float, resize, move, swap, groups
│   ├── workspaces.conf        #   Workspace switching, movement, monitor transfer
│   ├── media.conf             #   Volume, brightness, media keys, hardware buttons
│   ├── screenshots.conf       #   Screenshot variants (full, area, delayed, active)
│   └── custom.conf            #   System (lock, power), features, user scripts
│
├── rules/                     # Window and layer rules
│   ├── windows.conf           #   App categorization tags (browser, terminal, im, etc.)
│   ├── floating.conf          #   Float rules, named window rules (PiP, Thunar progress)
│   ├── opacity.conf           #   Per-category active/inactive opacity
│   ├── layers.conf            #   Wayland layer rules (rofi, notifications, quickshell)
│   └── workspaces.conf        #   Workspace-specific behaviors (idle inhibit, games)
│
├── services/                  # Startup and defaults
│   ├── startup.conf           #   exec-once services (ordered by dependency)
│   └── daemons.conf           #   Default apps, EDITOR env var
│
├── local/                     # User overrides (not modified by updates)
│   └── override.conf          #   Personal tweaks
│
├── scripts/                   # Organized by subsystem
│   ├── display/              #   MonitorProfiles, Brightness, TouchPad, Refresh
│   ├── media/                #   Volume, MediaCtrl, Sounds
│   ├── screenshots/          #   ScreenShot
│   ├── wallpaper/            #   WallustSwww
│   ├── system/               #   LockScreen, AirplaneMode, GameMode, Polkit, Hyprsunset
│   ├── input/                #   KeyBinds, KeyboardLayout, KeybindsLayoutInit
│   ├── theme/                #   ThemeChanger, DarkLight, Animations, Kitty_themes
│   ├── waybar/               #   WaybarLayout, WaybarStyles, WaybarCava
│   ├── rofi/                 #   RofiEmoji, RofiSearch, RofiThemeSelector, KeyHints
│   ├── utils/                #   ClipManager, Dropterminal, Wlogout, Kool_Quick_Settings
│   └── user/                 #   User scripts (Wallpaper*, RofiBeats, Weather*, etc.)
├── wallust/                   # Wallust color generation config
├── wallpaper_effects/         # Wallpaper processing files
├── hyprlock.conf              # Lock screen appearance
├── hypridle.conf              # Idle management timeouts
├── application-style.conf     # Qt hyprland-qt-support styling
└── docs/                      # This documentation
```

## File Naming Conventions

- **Lowercase with hyphens** for directories and files
- **Descriptive names** that indicate responsibility
- **No abbreviations** unless they're standard (env, misc, etc.)
- **.conf extension** for all Hyprland configuration files
