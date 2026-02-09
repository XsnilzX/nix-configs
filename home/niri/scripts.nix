{
  config,
  pkgs,
  ...
}: let
  scriptPath = "${config.home.homeDirectory}/.config/niri/scripts/wallpaper-cycle.sh";
in {
  home.file.".config/niri/scripts/wallpaper-cycle.sh" = {
    text = ''
      #!/usr/bin/env bash

      WALLPAPER_DIR="${config.home.homeDirectory}/Bilder/Wallpaper"
      INTERVAL=300

      if [ ! -d "$WALLPAPER_DIR" ]; then
        echo "Fehler: Wallpaper-Ordner existiert nicht: $WALLPAPER_DIR"
        exit 1
      fi

      while true; do
        random_background=$(ls "$WALLPAPER_DIR"/*.{jpg,jpeg,png} 2>/dev/null | shuf -n 1)

        if [ -n "$random_background" ]; then
          pkill -x swaybg 2>/dev/null || true
          swaybg -i "$random_background" -m fill &
        else
          echo "Keine Bilder im Ordner gefunden"
          exit 1
        fi

        sleep "$INTERVAL"
      done
    '';
    executable = true;
  };

  systemd.user.services.niri-wallpaper-cycle = {
    Unit = {
      Description = "Niri wallpaper cycle script";
      After = ["graphical-session.target"];
      PartOf = ["graphical-session.target"];
    };
    Service = {
      ExecStart = scriptPath;
      Restart = "always";
      RestartSec = 2;
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
