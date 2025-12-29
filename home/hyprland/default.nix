{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./anyrun.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./swaync.nix
    ./waybar.nix
    ./wleave.nix
  ];
}
