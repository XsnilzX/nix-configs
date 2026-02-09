{
  lib,
  config,
  pkgs,
  ...
}: let
  apps = import ./application.nix {inherit pkgs;};
in {
  programs.niri.settings.binds = with config.lib.niri.actions; let
    wpctl = "${pkgs.wpctl}/bin/wpctl";
    brightnessctl "${pkgs.brightnessctl}/bin/brightnessctl"

    volume-up = spawn wpctl ["set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"];
    volume-down = spawn wpctl ["set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"];
    volume-mute = spawn wpctl ["set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];
    mic-mute = spawn wpctl ["set-mute" "@DEFAULT_AUDIO_SURCE@" "toggle"];
    brightness-up = spawn brightnessctl ["s" "%5+"];
    brightness-down = spawn brightnessctl ["s" "5%-"];

  in {
    "Mod+q".action = spawn apps.terminal;
    "Mod+x".action = repeat=false close-window;
    "Mod+m".action = quit skip-confirmation=true;
    "Mod+e".action = spawn apps.fileManager;
    "Mod+v".action = toggle-window-floating;
    "Mod+Space".action = spawn apps.appLauncher;
    "Mod+b".action = spawn apps.browser;
    "Mod+t".action = spawn apps.mail;
    "Mod+c".action = spawn apps.code;
    "Mod+l".action = spawn "wleave";
    
    "Mod+Left".action = move-column-left;
  };
}
