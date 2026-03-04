{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.niri.homeModules.niri
    ./settings.nix
    ./keybinds.nix
    ./autostart.nix
    ./scripts.nix
    #./quickshell.nix
    ../hyprland/anyrun.nix
    ../hyprland/swaync.nix
    #../hyprland/waybar.nix
    ../hyprland/wleave.nix
  ];

  programs.swaylock.enable = true;
  programs.waybar.enable = true;
  services = {
    mako.enable = true;
    swayidle.enable = true;
    polkit-gnome.enable = true;
    udiskie = {
      enable = true;
      tray = "auto";
    };
  };
}
