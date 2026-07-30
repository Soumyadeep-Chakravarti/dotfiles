# Window Rules

## Tag System

Tags categorize windows by application type. They enable batch-applied rules without repeating class regexes.

### How Tags Work

1. `rules/windows.conf` assigns tags based on window class
2. `rules/opacity.conf` applies opacity per tag
3. `rules/floating.conf` applies float rules per tag
4. Adding a new app to a category = one line in `rules/windows.conf`

### Available Tags

| Tag | Purpose | Apps |
|-----|---------|------|
| `browser` | Web browsers | Firefox, Chrome, Chromium, Edge, Brave, Zen |
| `terminal` | Terminal emulators | kitty, Alacritty |
| `file-manager` | File browsers | Thunar, Nautilus, pcmanfm-qt |
| `email` | Email clients | Thunderbird, Betterbird, Evolution |
| `projects` | IDEs and editors | VSCode, VSCodium, JetBrains, Zed |
| `im` | Instant messaging | Discord, Vesktop, Ferdium, WhatsApp, Telegram, Teams, Element |
| `games` | Game windows | gamescope, steam_app_* |
| `gamestore` | Game launchers | Steam, Lutris, Heroic |
| `multimedia` | Audio players | Audacious |
| `multimedia_video` | Video players | mpv, vlc |
| `settings` | Settings dialogs | pavucontrol, nm-applet, rofi, file-roller |
| `viewer` | Viewers | System monitor, Evince, Loupe |
| `notif` | Notifications | swaync |
| `wallpaper` | Wallpaper tools | Waytrogen |

## Adding a New App

**To add a new browser:**
```conf
# In rules/windows.conf, under the Browser section:
windowrule = match:class ^(MyNewBrowser)$, tag +browser
```

That's it. It inherits all opacity, float, and size rules from the browser tag.

**To add a new category:**
1. Add tag definitions in `rules/windows.conf`
2. Add opacity rules in `rules/opacity.conf` (if needed)
3. Add float rules in `rules/floating.conf` (if needed)

## Named Rules

Some windows need complex rule combinations. These use Hyprland's named rule syntax:

```conf
windowrule {
    name = Picture-in-Picture
    match:title = ^(Picture-in-Picture)$
    float = on
    move = 72% 7%
    opacity = 0.95 0.75
    pin = on
    keep_aspect_ratio = on
    size = (monitor_w*0.3) (monitor_h*0.3)
}
```

Named rules are in `rules/floating.conf`.

## Layer Rules

Wayland layers (rofi, notifications, quickshell) use `layerrule` in `rules/layers.conf`:

```conf
layerrule = match:namespace rofi, blur on
layerrule = match:namespace notifications, blur on
layerrule = match:namespace quickshell:overview, blur on
layerrule = match:namespace quickshell:overview, ignore_alpha 0.5
```
