{
  lib,
  compositor,
  ...
}:
lib.mkIf (compositor == "niri") {
  programs.niri.enable = true;

  security.polkit.enable = true; # polkit
  services.displayManager.ly.enable = true;
  services.gnome.gnome-keyring.enable = true; # secret service
  security.pam.services.swaylock = {};

  programs.waybar.enable = true; # top bar
}
