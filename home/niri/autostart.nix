{
  lib,
  pkgs,
  ...
}: {
  programs.niri.settings.spawn-at-startup = [
    {command = ["swayidle"];}
    {command = ["swaync"];}
    {command = ["nm-applet" "--indicator"];}
    {command = ["blueman-applet"];}
    {command = ["udiskie"];}
    {command = ["seafile-applet"];}
    {command = ["systemctl" "--user" "start" "polkit-gnome-authentication-agent-1"];}
  ];
}
