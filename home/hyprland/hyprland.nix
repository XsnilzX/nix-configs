{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = "eDP-1,1920x1080@60,0x0,1";
      exec-once = [
        "waybar"
        "nm-applet --indicator"
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

  home.packages = with pkgs; [
    waybar
    hyprpaper
    hyprpicker
    hyprshot
  ];

  # Beispiel: Hyprland Autostart
  home.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
  };
}
