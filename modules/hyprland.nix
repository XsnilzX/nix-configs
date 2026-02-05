{
  pkgs,
  lib,
  compositor,
  ...
}:
lib.mkIf (compositor == "hyprland") {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
  services = {
    blueman.enable = true;
    displayManager.ly.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;
  };
}
