{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = "DP-1,2880x1800@120,0x0,1";

      # default programs
      "$mainMod" = "SUPER";
      "$terminal" = "ghostty";
      "$fileManager" = "thunar";
      "$menu" = "anyrun";
      "$browser" = "zen-browser";
      "$mail" = "thunderbird";
      "$code" = "vscodium --ozone-platform=wayland";

      # am anfang starten
      exec-once = [
        "hypridle"
        "nm-applet --indicator & blueman-applet"
        "waybar & hyprpaper"
        "systemctl --user start hyprpolkitagent"
        "swaync"
        "udiskie"
      ];
      input = {
        kb_layout = "de";
        follow_mouse = 1;
      };
      decoration = {
        rounding = 5;
        blur = true;
      };
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";       # avoid starting multiple hyprlock instances.
        before_sleep_cmd = "hyprlock";                 # lock before suspend.
        after_sleep_cmd = "hyprctl dispatch dpms on";  # to avoid having to press a key twice to turn on the display.
      };
      listener = [
        {
          timeout = 150;                              # 2.5min.
          before_sleep_cmd = "brightnessctl set 5";   # set monitor backlight to minimum, avoid 0 on OLED monitor.
          after_sleep_cmd = "brightnessctl -r";       # monitor backlight restore.
        }
        # turn off keyboard backlight, comment out this section if you dont have a keyboard backlight.
        {
          timeout = 150;                                                     # 2.5min.
          on-timeout = "brightnessctl -d platform::kbd_backlight set 0";     # turn off keyboard backlight.
          on-resume = "brightnessctl -d platform::kbd_backlight set 1";      # turn on keyboard backlight.
        }
        {
          timeout = 300;                                   # 5min
          on-timeout = "hyprlock";                         # lock screen when timeout has passed
          on-resume = "hyprlock";                          # lock screen after wakeup
        }
        {
          timeout = 350;                                   # 5.5min
          on-timeout = "hyprctl dispatch dpms off";        # screen off when timeout has passed
          on-resume = "hyprctl dispatch dpms on";          # screen on when activity is detected after timeout has fired.
        }
        {
          timeout = 1800;                                  # 30min
          on-timeout = "systemctl suspend";                # suspend pc
        }
      ];
    };
  };

  services.hyprpolkitagent.enable = true;
  services.udiskie.enable = true;

  home.packages = with pkgs; [
    waybar
    hyprpaper
    hyprpicker
    hyprshot
  ];

  programs.hyprshot = {
    enable = true;
    saveLocation = "$HOME/Bilder/Screenshots";
  };

  services.blueman.enable = true;
  services.blueman-applet.enable = true;

  # Beispiel: Hyprland Autostart
  home.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
  };
}
