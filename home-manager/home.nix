{ config, pkgs, inputs, ... }:

{
  imports = [
    ./niri.nix
    # The niri home-manager module is automatically imported via the NixOS module
  ];

  # Set your state version
  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Your user packages will go here
  home.packages = with pkgs; [
    kitty
    fuzzel
  ];

  # Waybar configuration
  programs.waybar = {
    enable = true;
    systemd.enable = true;
  };

  # Mako notification daemon
  services.mako = {
    enable = true;
    defaultTimeout = 5000;
  };

  # Clipboard manager
  services.cliphist.enable = true;
}
