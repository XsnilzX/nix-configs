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
    ../hyprland/anyrun.nix
    ../hyprland/swaync.nix
    #../hyprland/waybar.nix
    ../hyprland/wleave.nix
  ];
}
