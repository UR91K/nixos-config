# NixOS Niri Setup Summary

## What Was Added

### Flake Inputs (flake.nix)
- **Zen Browser flake** - Firefox-based browser with sideways tabs

### System Packages (configuration.nix)
- **zen-browser** - Modern Firefox-based browser
- **nautilus** - GNOME file manager
- **waybar** - Status bar for Wayland
- **grim + slurp** - Screenshot tools (Mod+Shift+S)
- **wl-clipboard** - Clipboard utilities
- **mako** - Notification daemon
- **networkmanagerapplet** - WiFi GUI
- **blueman** - Bluetooth manager
- **swaylock** - Screen locker (Mod+L)
- **cliphist** - Clipboard history manager
- **imv** - Image viewer
- **evince** - PDF viewer
- **pavucontrol** - Audio control GUI

### System Services (configuration.nix)
- **services.gvfs.enable** - Enables trash, network drives for Nautilus
- **services.udisks2.enable** - Auto-mount USB drives

### Home Manager Services (home.nix)
- **waybar** - Configured with systemd integration
- **mako** - Notification daemon (5s timeout)
- **cliphist** - Clipboard manager service

### New Keybinds (niri.nix)
- `Mod+B` - Zen Browser
- `Mod+E` - Nautilus file manager
- `Mod+L` - Lock screen (swaylock)
- `Mod+Shift+S` - Screenshot (select area, copy to clipboard)

## Next Steps

### 1. Rebuild Your System
```bash
sudo nixos-rebuild switch --flake /etc/nixos#nixos
```

### 2. Install Kiro IDE
After rebuild, run:
```bash
curl -fsSL https://cli.kiro.dev/install | bash
```

### 3. Configure Waybar (Optional)
Waybar will start automatically but has default config. To customize:
```bash
mkdir -p ~/.config/waybar
# Edit ~/.config/waybar/config and ~/.config/waybar/style.css
```

### 4. Configure Swaylock (Optional)
Create `~/.config/swaylock/config` for custom lock screen appearance.

## Key Features Now Available

✅ Complete desktop environment with status bar
✅ File manager with trash and USB support
✅ Modern browser (Zen)
✅ Screenshot tools
✅ Notifications
✅ Network/Bluetooth GUIs
✅ Screen locking
✅ Clipboard history
✅ Media viewers
✅ Audio controls

## Troubleshooting

If Zen Browser doesn't launch, check:
```bash
which zen-browser
```

If Waybar doesn't appear, manually start it:
```bash
waybar &
```

For Nautilus issues with trash/network:
```bash
echo $GIO_EXTRA_MODULES  # Should be set after rebuild
```
