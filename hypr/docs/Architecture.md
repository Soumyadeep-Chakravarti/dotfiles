# Architecture

## Design Principles

1. **Single responsibility** - Each file handles one concern
2. **Single source of truth** - Variables defined once in `core/variables.conf`
3. **Layered overrides** - Source order determines precedence; later files override earlier ones
4. **Discoverability** - File names tell you where to look

## Module Dependency Graph

```
core/variables.conf          ← defines $mainMod, $term, $files, $scriptsDir, etc.
    │
core/environment.conf        ← env vars (references nothing)
core/compositor.conf         ← dwindle, master, general, xwayland, cursor
core/misc.conf               ← misc{} settings
    │
display/monitors.conf        ← monitor outputs (nwg-displays managed)
display/workspaces.conf      ← workspace rules
    │
input/keyboard.conf          ← kb_layout, repeat_rate
input/mouse.conf             ← sensitivity, follow_mouse
input/touchpad.conf          ← natural_scroll, tap-to-click
input/gestures.conf          ← 3/4-finger gestures (references $scriptsDir)
    │
appearance/colors.conf       ← sources wallust/wallust-hyprland.conf
appearance/decoration.conf   ← borders, gaps, opacity, shadow (sources colors.conf)
appearance/animations.conf   ← bezier curves, animation timing
appearance/blur.conf         ← blur passes, size, xray
appearance/cursor.conf       ← cursor theme, hardware cursors
    │
bindings/applications.conf   ← $term, $files (from variables.conf)
bindings/windows.conf        ← close, float, resize, groups
bindings/workspaces.conf     ← workspace switching, monitor movement
bindings/media.conf          ← volume, brightness, hardware keys
bindings/screenshots.conf    ← screenshot variants
bindings/custom.conf         ← features, system, user scripts
    │
rules/windows.conf           ← app categorization tags
rules/floating.conf          ← float rules (references tags)
rules/opacity.conf           ← opacity rules (references tags)
rules/layers.conf            ← wayland layer rules
rules/workspaces.conf        ← workspace-specific behaviors
    │
services/startup.conf        ← exec-once (ordered by dependency)
services/daemons.conf        ← default apps, EDITOR env
    │
local/override.conf          ← personal tweaks (last source = highest priority)
```

## Why This Order Matters

1. **Variables first** - Everything else references them
2. **Environment before compositor** - Some env vars affect rendering
3. **Compositor before input** - Input settings depend on general{} existing
4. **Appearance after compositor** - Decoration extends general{} and decoration{}
5. **Bindings after variables** - All keybinds use $mainMod, $scriptsDir
6. **Rules after appearance** - Rules reference tags and may set opacity
7. **Services last before local** - Startup depends on everything being configured
8. **Local override absolute last** - User tweaks override everything

## Adding a New Module

1. Create the file in the appropriate directory
2. Add a `source =` line in `hyprland.conf` at the correct position
3. Document the file's responsibility in its header comment
4. If it defines variables, add them to `core/variables.conf` instead
