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
    ../hyprland/anyrun.nix
    ../hyprland/swaync.nix
    #../hyprland/waybar.nix
    ../hyprland/wleave.nix
  ];

  programs.swaylock.enable = true;
  programs.waybar.enable = true;
  services.mako.enable = true;
  services.swayidle.enable = true;
  services.polkit-gnome.enable = true;
}
