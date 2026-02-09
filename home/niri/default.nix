{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.niri.homeModules.niri
    ../hyprland/anyrun.nix
    ../hyprland/swaync.nix
    #../hyprland/waybar.nix
    ../hyprland/wleave.nix
    ./niri.nix
  ];
}
