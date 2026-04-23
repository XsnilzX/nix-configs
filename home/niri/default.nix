{inputs, ...}: {
  imports = [
    inputs.niri.homeModules.niri
    ../../modules/home/waybar
    ./settings.nix
    ./keybinds.nix
    ./autostart.nix
    ./scripts.nix
    #./quickshell.nix
    ../hyprland/anyrun.nix
    ../hyprland/swaync.nix
    ../hyprland/wleave.nix
  ];

  programs.swaylock.enable = true;
  modules.waybar = {
    enable = true;
    compositor = "niri";
  };
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
