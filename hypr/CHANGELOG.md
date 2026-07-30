# Changelog

All notable changes to this Hyprland configuration are documented here.

Format follows [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [2.4.0] - 2026-07-04

### Changed
- **Scripts reorganized** into 10 subsystem directories by responsibility:
  - `display/` — MonitorProfiles, Brightness, BrightnessKbd, TouchPad, Refresh, RefreshNoWaybar
  - `media/` — Volume, MediaCtrl, Sounds
  - `screenshots/` — ScreenShot
  - `wallpaper/` — WallustSwww
  - `system/` — LockScreen, AirplaneMode, GameMode, Polkit, Polkit-NixOS, PortalHyprland, Hyprsunset, Hypridle, KillActiveProcess, Distro_update, Battery, UptimeNixOS
  - `input/` — KeyBinds, KeyboardLayout, KeybindsLayoutInit, KeyHints, keybinds_parser
  - `theme/` — ThemeChanger, DarkLight, Animations, Kitty_themes, ChangeBlur, ChangeLayout
  - `waybar/` — WaybarLayout, WaybarStyles, WaybarCava, WaybarScripts
  - `rofi/` — RofiEmoji, RofiSearch, RofiThemeSelector
  - `utils/` — ClipManager, Dropterminal, Wlogout, Kool_Quick_Settings, KooLsDotsUpdate, OverviewToggle, Tak0-Autodispatch, Tak0-Per-Window-Switch, UserConfigsSwitcher, sddm_wallpaper, update_WindowRules
  - `user/` — User scripts (Wallpaper*, RofiBeats, RofiCalc, Weather*, ZshChangeTheme, RainbowBorders)

- **`$UserScripts` variable** now points to `$scriptsDir/user` (was a separate top-level directory)

- **All config references** updated to match new script paths (35+ binding/command references)

- **Git initialized** with conventional commit history

### Fixed
- Mismatch between `$UserScripts` variable definition and actual script location

## [2.3.20] - Original
- Base configuration from JaKooLit Hyprland dots
