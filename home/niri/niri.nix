{
  config,
  pkgs,
  ...
}: let
  scriptPath = "${config.home.homeDirectory}/.config/niri/scripts/wallpaper-cycle.sh";
in {
  programs.alacritty.enable = true; # Super+T in the default setting (terminal)
  programs.fuzzel.enable = true; # Super+D in the default setting (app launcher)
  programs.swaylock.enable = true; # Super+Alt+L in the default setting (screen locker)
  programs.waybar.enable = true; # launch on startup in the default setting (bar)
  services.mako.enable = true; # notification daemon
  services.swayidle.enable = true; # idle management daemon
  services.polkit-gnome.enable = true; # polkit
  home.packages = with pkgs; [
    swaybg # wallpaper
    xwayland-satellite # xwayland support
  ];

  xdg.configFile."niri/config.kdl".text = ''
    // Autostart (angepasst von Hyprland exec-once)
    spawn-at-startup "swayidle"
    spawn-at-startup "nm-applet" "--indicator"
    spawn-at-startup "blueman-applet"
    spawn-at-startup "waybar"
    spawn-at-startup "swaync"
    spawn-at-startup "udiskie"
    spawn-at-startup "seafile-applet"
    spawn-at-startup "systemctl" "--user" "start" "polkit-gnome-authentication-agent-1"

    // Beispiel: Fensterplatzierung per App-ID
    window-rule {
      match app-id="firefox$"
      open-on-workspace "2"
    }

    binds {
      Super+Q { spawn "ghostty"; }
      Super+X repeat=false { close-window; }
      Super+M { quit skip-confirmation=true; }
      Super+E { spawn "thunar"; }
      Super+V { toggle-window-floating; }
      Super+Space { spawn "anyrun"; }
      Super+B { spawn "helium"; }
      Super+T { spawn "thunderbird"; }
      Super+C { spawn "vscodium" "--ozone-platform=wayland"; }
      Super+L { spawn "swaylock"; }

      Super+Shift+S {
        spawn-sh "wayshot -f ${config.home.homeDirectory}/Bilder/screenshots/$(date '+%Y%m%d-%H:%M:%S').png";
      }
      Super+S {
        spawn-sh "wayshot -s \"$(slurp)\" -f ${config.home.homeDirectory}/Bilder/screenshots/$(date '+%Y%m%d-%H:%M:%S').png";
      }

      Super+Left { focus-column-left; }
      Super+Right { focus-column-right; }
      Super+Up { focus-window-up; }
      Super+Down { focus-window-down; }

      Super+1 { focus-workspace 1; }
      Super+2 { focus-workspace 2; }
      Super+3 { focus-workspace 3; }
      Super+4 { focus-workspace 4; }
      Super+5 { focus-workspace 5; }
      Super+6 { focus-workspace 6; }
      Super+7 { focus-workspace 7; }
      Super+8 { focus-workspace 8; }
      Super+9 { focus-workspace 9; }
      Super+0 { focus-workspace 10; }

      Super+Shift+1 { move-window-to-workspace 1; }
      Super+Shift+2 { move-window-to-workspace 2; }
      Super+Shift+3 { move-window-to-workspace 3; }
      Super+Shift+4 { move-window-to-workspace 4; }
      Super+Shift+5 { move-window-to-workspace 5; }
      Super+Shift+6 { move-window-to-workspace 6; }
      Super+Shift+7 { move-window-to-workspace 7; }
      Super+Shift+8 { move-window-to-workspace 8; }
      Super+Shift+9 { move-window-to-workspace 9; }
      Super+Shift+0 { move-window-to-workspace 10; }

      Super+WheelScrollDown cooldown-ms=150 { focus-workspace-down; }
      Super+WheelScrollUp cooldown-ms=150 { focus-workspace-up; }

      XF86AudioRaiseVolume allow-when-locked=true {
        spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
      }
      XF86AudioLowerVolume allow-when-locked=true {
        spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
      }
      XF86AudioMute allow-when-locked=true {
        spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      }
      XF86AudioMicMute allow-when-locked=true {
        spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
      }
      XF86MonBrightnessUp allow-when-locked=true {
        spawn-sh "brightnessctl s 5%+";
      }
      XF86MonBrightnessDown allow-when-locked=true {
        spawn-sh "brightnessctl s 5%-";
      }

      XF86AudioNext allow-when-locked=true { spawn-sh "playerctl next"; }
      XF86AudioPause allow-when-locked=true { spawn-sh "playerctl play-pause"; }
      XF86AudioPlay allow-when-locked=true { spawn-sh "playerctl play-pause"; }
      XF86AudioPrev allow-when-locked=true { spawn-sh "playerctl previous"; }

      Mod+Shift+Slash { show-hotkey-overlay; }
      Mod+O repeat=false { toggle-overview; }

      Mod+H { focus-column-left; }
      Mod+J { focus-window-down; }
      Mod+K { focus-window-up; }
      Mod+L { focus-column-right; }

      Mod+Ctrl+H { move-column-left; }
      Mod+Ctrl+J { move-window-down; }
      Mod+Ctrl+K { move-window-up; }
      Mod+Ctrl+L { move-column-right; }

      Mod+Home { focus-column-first; }
      Mod+End { focus-column-last; }
      Mod+Ctrl+Home { move-column-to-first; }
      Mod+Ctrl+End { move-column-to-last; }

      Mod+Shift+H { focus-monitor-left; }
      Mod+Shift+J { focus-monitor-down; }
      Mod+Shift+K { focus-monitor-up; }
      Mod+Shift+L { focus-monitor-right; }

      Mod+Shift+Ctrl+H { move-column-to-monitor-left; }
      Mod+Shift+Ctrl+J { move-column-to-monitor-down; }
      Mod+Shift+Ctrl+K { move-column-to-monitor-up; }
      Mod+Shift+Ctrl+L { move-column-to-monitor-right; }

      Mod+Page_Down { focus-workspace-down; }
      Mod+Page_Up { focus-workspace-up; }
      Mod+U { focus-workspace-down; }
      Mod+I { focus-workspace-up; }
      Mod+Ctrl+Page_Down { move-column-to-workspace-down; }
      Mod+Ctrl+Page_Up { move-column-to-workspace-up; }
      Mod+Ctrl+U { move-column-to-workspace-down; }
      Mod+Ctrl+I { move-column-to-workspace-up; }

      Mod+Shift+Page_Down { move-workspace-down; }
      Mod+Shift+Page_Up { move-workspace-up; }
      Mod+Shift+U { move-workspace-down; }
      Mod+Shift+I { move-workspace-up; }

      Mod+WheelScrollDown cooldown-ms=150 { focus-workspace-down; }
      Mod+WheelScrollUp cooldown-ms=150 { focus-workspace-up; }
      Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
      Mod+Ctrl+WheelScrollUp cooldown-ms=150 { move-column-to-workspace-up; }

      Mod+WheelScrollRight { focus-column-right; }
      Mod+WheelScrollLeft { focus-column-left; }
      Mod+Ctrl+WheelScrollRight { move-column-right; }
      Mod+Ctrl+WheelScrollLeft { move-column-left; }

      Mod+Shift+WheelScrollDown { focus-column-right; }
      Mod+Shift+WheelScrollUp { focus-column-left; }
      Mod+Ctrl+Shift+WheelScrollDown { move-column-right; }
      Mod+Ctrl+Shift+WheelScrollUp { move-column-left; }

      Mod+BracketLeft { consume-or-expel-window-left; }
      Mod+BracketRight { consume-or-expel-window-right; }
      Mod+Comma { consume-window-into-column; }
      Mod+Period { expel-window-from-column; }

      Mod+R { switch-preset-column-width; }
      Mod+Shift+R { switch-preset-window-height; }
      Mod+Ctrl+R { reset-window-height; }
      Mod+F { maximize-column; }
      Mod+Shift+F { fullscreen-window; }
      Mod+Ctrl+F { expand-column-to-available-width; }

      Mod+Minus { set-column-width "-10%"; }
      Mod+Equal { set-column-width "+10%"; }
      Mod+Shift+Minus { set-window-height "-10%"; }
      Mod+Shift+Equal { set-window-height "+10%"; }

      Mod+Shift+V { switch-focus-between-floating-and-tiling; }
      Mod+W { toggle-column-tabbed-display; }

      Print { screenshot; }
      Ctrl+Print { screenshot-screen; }
      Alt+Print { screenshot-window; }

      Mod+Escape allow-inhibiting=false { toggle-keyboard-shortcuts-inhibit; }
      Mod+Shift+E { quit; }
      Ctrl+Alt+Delete { quit; }
      Mod+Shift+P { power-off-monitors; }
    }
  '';

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
