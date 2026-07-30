# Startup Flow

## Execution Order

Services start in dependency order. Each must be able to run independently.

```
1. Environment setup
   ├── dbus-update-activation-environment
   └── systemctl import-environment
       ↓
2. Wallpaper engine
   └── awww-daemon --format xrgb
       ↓
3. Authentication
   └── polkit agent
       ↓
4. Network and Bluetooth
   ├── nm-applet
   └── blueman-applet
       ↓
5. Clipboard history
   ├── wl-paste --type text --watch cliphist store
   └── wl-paste --type image --watch cliphist store
       ↓
6. Bar and shell
   ├── waybar
   └── quickshell overview
       ↓
7. Idle management
   ├── hypridle
   └── hyprsunset init
       ↓
8. Layout initialization
   └── KeybindsLayoutInit.sh (sets J/K binds per layout)
```

## Why This Order

1. **Environment first** - D-Bus and systemd need WAYLAND_DISPLAY set before anything uses them
2. **Wallpaper before bar** - Waybar may reference wallpaper colors
3. **Auth before network** - nm-applet may prompt for credentials
4. **Clipboard before bar** - Waybar clipboard module needs cliphist running
5. **Bar before apps** - Users expect bar visible immediately
6. **Idle last** - No point locking screen before everything is running

## Modifying Startup

- Add new services to `services/startup.conf`
- Use `exec-once =` for one-shot commands
- Use `exec =` for commands that should restart if they crash
- Order matters: put dependencies before dependents
