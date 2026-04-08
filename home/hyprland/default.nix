{
  imports = [
    ../../modules/home/waybar
    ./anyrun.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./swaync.nix
    ./wallpapercycle.nix
    ./wleave.nix
  ];

  modules.waybar = {
    enable = true;
    compositor = "hyprland";
  };
}
