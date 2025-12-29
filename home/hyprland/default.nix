{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./anyrun.nix
    ./hyprland.nix
    ./swaync.nix
    ./waybar.nix
    ./wleave.nix
  ];
}
