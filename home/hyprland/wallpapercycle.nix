{
  config,
  pkgs,
  ...
}: let
  scriptPath = "${config.home.homeDirectory}/.config/hypr/scripts/wallpaper-cycle.sh";
in {
  # Script ins Home schreiben
  home.file.".config/hypr/scripts/wallpaper-cycle.sh" = {
    text = ''
      #!/usr/bin/env bash

      # Konfigurationsvariablen
      WALLPAPER_DIR="${config.home.homeDirectory}/Bilder/Wallpaper"
      INTERVAL=300
      MONITOR="eDP-1"

      echo "PID: $$ Script: ${scriptPath}" > /tmp/wallpaperscript.txt

      if [ ! -d "$WALLPAPER_DIR" ]; then
          echo "Fehler: Wallpaper-Ordner existiert nicht: $WALLPAPER_DIR"
          exit 1
      fi

      while true; do
          if [ -d "$WALLPAPER_DIR" ]; then
              # Wähle zufälliges Wallpaper
              random_background=$(ls "$WALLPAPER_DIR"/*.{jpg,jpeg,png} 2>/dev/null | shuf -n 1)

              if [ -n "$random_background" ]; then
                  hyprctl hyprpaper unload all
                  hyprctl hyprpaper preload "$random_background"
                  hyprctl hyprpaper wallpaper "$MONITOR,$random_background"

                  echo "Wallpaper gewechselt zu: $random_background"
              else
                  echo "Keine Bilder im Ordner gefunden"
                  exit 1
              fi
          fi

          sleep "$INTERVAL"
      done
    '';
    executable = true;
  };

  # systemd-User-Service, der das Script startet
  systemd.user.services.hyprpaper-wallpaper-cycle = {
    Unit = {
      Description = "Hyprpaper wallpaper cycle script";
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
