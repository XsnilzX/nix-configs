{
  config,
  pkgs,
  ...
}: let
  scriptPath = "${config.home.homeDirectory}/.config/niri/scripts/wallpaper-cycle.sh";
in {
  home.file.".config/niri/scripts/wallpaper-cycle.sh" = {
    executable = true;
    text = ''
      #!${pkgs.bash}/bin/bash
      set -euo pipefail

      WALLPAPER_DIR="${config.home.homeDirectory}/Bilder/Wallpaper"
      INTERVAL=300

      FIND=${pkgs.findutils}/bin/find
      SHUF=${pkgs.coreutils}/bin/shuf
      PKILL=${pkgs.procps}/bin/pkill
      SWAYBG=${pkgs.swaybg}/bin/swaybg
      SLEEP=${pkgs.coreutils}/bin/sleep
      ID=${pkgs.coreutils}/bin/id

      if [ -z "''${WAYLAND_DISPLAY:-}" ]; then
        runtime_dir="''${XDG_RUNTIME_DIR:-/run/user/$($ID -u)}"

        if [ -d "$runtime_dir" ]; then
          while IFS= read -r socket; do
            if [ -n "$socket" ]; then
              WAYLAND_DISPLAY="''${socket##*/}"
              export WAYLAND_DISPLAY
              break
            fi
          done < <($FIND "$runtime_dir" -maxdepth 1 -type s -name "wayland-*")
        fi
      fi

      while true; do
        if [ -z "''${WAYLAND_DISPLAY:-}" ]; then
          $SLEEP 5
          continue
        fi

        if [ ! -d "$WALLPAPER_DIR" ]; then
          $SLEEP "$INTERVAL"
          continue
        fi

        mapfile -t wallpapers < <(
          $FIND "$WALLPAPER_DIR" -maxdepth 1 -type f \
            \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \)
        )

        if [ "''${#wallpapers[@]}" -eq 0 ]; then
          $SLEEP "$INTERVAL"
          continue
        fi

        random_background=$(printf '%s\n' "''${wallpapers[@]}" | $SHUF -n 1)

        if [ -n "$random_background" ]; then
          $PKILL swaybg || true
          $SWAYBG -i "$random_background" -m fill &
        fi

        $SLEEP "$INTERVAL"
      done
    '';
  };

  systemd.user.services.niri-wallpaper-cycle = {
    Unit = {
      Description = "Niri wallpaper cycle";
      After = ["graphical-session.target"];
      PartOf = ["graphical-session.target"];
    };

    Service = {
      ExecStart = "${pkgs.bash}/bin/bash ${scriptPath}";
      Restart = "always";
      RestartSec = 5;
    };

    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
