{ config, pkgs, ... }:

{
  programs.niri = {
    enable = true;
    # This is where all your Niri-specific settings go
    settings = {
      input = {
        keyboard.repeat-delay = 250;
        touchpad = {
          tap = true;
          dwt = true; # disable-while-typing
        };
      };

      layout = {
        gaps = 5;
        struts = {
          left = 0;
          right = 0;
          top = 0;
          bottom = 0;
        };
      };

      # Basic Keybindings
      binds = with config.lib.niri.actions; {
        "Mod+T".action = spawn "kitty";
        "Mod+R".action = spawn "fuzzel"; # A popular Wayland launcher
        "Mod+Q".action = close-window;
        "Mod+Shift+E".action = quit;

        # Audio/Brightness (Modern laptop keys)
        "XF86AudioRaiseVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+";
        "XF86AudioLowerVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-";
      };
    };
  };
}
