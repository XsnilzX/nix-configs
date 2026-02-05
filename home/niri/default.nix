{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../hyprland/anyrun.nix
    ../hyprland/swaync.nix
    ../hyprland/waybar.nix
    ../hyprland/wleave.nix
    ./niri.nix
  ];
}
