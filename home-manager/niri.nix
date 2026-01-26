{ config, pkgs, ... }:

{
  # Additional packages for clipboard support
  home.packages = [
    pkgs.wl-clipboard-rs
  ];

  # XDG Portal configuration for file pickers, screenshots, etc.
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config.niri = {
      default = ["gtk" "gnome"];
      "org.freedesktop.impl.portal.Access" = [ "gtk" ];
      "org.freedesktop.impl.portal.Notification" = [ "gtk" ];
      "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
      "org.freedesktop.impl.portal.ScreenCast" = [ "xdg-desktop-portal-gnome" ];
      "org.freedesktop.impl.portal.Screenshot" = [ "xdg-desktop-portal-gnome" ];
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
  };

  programs.niri = {
    # enable is set at the system level via programs.niri.enable in configuration.nix
    # This is where all your Niri-specific settings go
    settings = {
      # Wayland environment variables for better app compatibility
      environment = {
        "QT_QPA_PLATFORM" = "wayland";
        "XDG_SESSION_TYPE" = "wayland";
        "NIXOS_OZONE_WL" = "1";
        "MOZ_ENABLE_WAYLAND" = "1";
        "MOZ_WEBRENDER" = "1";
        "_JAVA_AWT_WM_NONREPARENTING" = "1";
        "QT_WAYLAND_DISABLE_WINDOWDECORATION" = "1";
        "GDK_BACKEND" = "wayland";
      };

      prefer-no-csd = true;
      screenshot-path = "~/Pictures/screenshots/%Y-%m-%dT%H:%M:%S%:z.png";
      hotkey-overlay.skip-at-startup = false; # Show hotkeys on startup

      input = {
        keyboard = {
          repeat-delay = 250;
          repeat-rate = 50;
        };
        touchpad = {
          tap = true;
          dwt = true; # disable-while-typing
          dwtp = true; # disable-while-typing-pointer
          natural-scroll = false;
          accel-profile = "flat";
        };
        mouse = {
          accel-speed = 0.0;
          accel-profile = "flat";
        };
        power-key-handling.enable = false;
      };

      layout = {
        gaps = 5;
        center-focused-column = "never";
        
        preset-column-widths = [
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 0.66667; }
        ];
        
        default-column-width = {
          proportion = 0.5;
        };
        
        preset-window-heights = [
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 0.66667; }
        ];

        focus-ring = {
          enable = true;
          width = 2;
          active.color = "#7fc8ff";
          inactive.color = "#505050";
        };

        border = {
          enable = false;
          width = 2;
          active.color = "#ffc87f";
          inactive.color = "#505050";
        };

        struts = {
          left = 0;
          right = 0;
          top = 0;
          bottom = 0;
        };
      };

      # Keybindings
      binds = with config.lib.niri.actions; {
        # Application launchers
        "Mod+T".action = spawn "kitty";
        "Mod+E".action = spawn "nautilus"; # File browser
        "Mod+B".action = spawn "zen-browser"; # Zen Browser
        "Alt+Space".action = spawn "fuzzel";
        "Menu".action = spawn "fuzzel";
        
        # Window management
        "Alt+F4".action = close-window;
        "Mod+Q".action = close-window;
        "Mod+F".action = toggle-window-floating;
        "Mod+Ctrl+F".action = switch-focus-between-floating-and-tiling;
        "Mod+Space".action = fullscreen-window;
        "Mod+Return".action = maximize-column;
        "Mod+Ctrl+Return".action = expand-column-to-available-width;

        # Window/Column navigation
        "Mod+Left".action = focus-column-left;
        "Mod+Right".action = focus-column-right;
        "Mod+Up".action = focus-window-or-workspace-up;
        "Mod+Down".action = focus-window-or-workspace-down;

        # Move windows/columns
        "Mod+Shift+Left".action = move-column-left;
        "Mod+Shift+Right".action = move-column-right;
        "Mod+Shift+Up".action = move-window-up;
        "Mod+Shift+Down".action = move-window-down;

        # Multi-monitor navigation
        "Mod+Ctrl+Left".action = focus-monitor-left;
        "Mod+Ctrl+Right".action = focus-monitor-right;
        "Mod+Ctrl+Up".action = focus-monitor-up;
        "Mod+Ctrl+Down".action = focus-monitor-down;

        # Move to monitor
        "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left;
        "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;
        "Mod+Shift+Ctrl+Up".action = move-column-to-monitor-up;
        "Mod+Shift+Ctrl+Down".action = move-column-to-monitor-down;

        # Column manipulation
        "Mod+Home".action = focus-column-first;
        "Mod+End".action = focus-column-last;
        "Mod+Alt+Left".action = consume-or-expel-window-left;
        "Mod+Alt+Right".action = consume-or-expel-window-right;

        # Screenshot
        "Mod+Shift+S".action = spawn "grim" "-g" "$(slurp)" "-" "|" "wl-copy";

        # Show hotkeys overlay
        "Mod+H".action = show-hotkey-overlay;

        # System
        "Mod+Shift+E".action = quit;
        "Mod+Ctrl+Shift+Q".action = quit;
        "Mod+Shift+P".action = power-off-monitors;
        "Mod+L".action = spawn "swaylock";

        # Audio controls
        "XF86AudioRaiseVolume" = {
          action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+";
          allow-when-locked = true;
        };
        "XF86AudioLowerVolume" = {
          action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-";
          allow-when-locked = true;
        };
        "XF86AudioMute" = {
          action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
          allow-when-locked = true;
        };
        "XF86AudioMicMute" = {
          action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
          allow-when-locked = true;
        };
      };
    };
  };
}
