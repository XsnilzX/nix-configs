{
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
  };

  programs.myQuickshell.enable = lib.mkForce false;

  programs.niri.settings.spawn-at-startup = lib.mkAfter [
    { command = [ "noctalia-shell" ]; }
  ];
}
