{
  config,
  lib,
  compositor ? "hyprland",
  ...
}: let
  cfg = config.modules.waybar;

  compositorModules = {
    hyprland = {
      left = [
        "hyprland/workspaces"
        "hyprland/window"
      ];
      center = ["clock"];
      right = [
        "network"
        "battery"
        "tray"
      ];
    };

    niri = {
      left = [
        "niri/workspaces"
        "niri/window"
      ];
      center = ["clock"];
      right = [
        "network"
        "battery"
        "tray"
        "custom/niri-picker"
      ];
    };

    sway = {
      left = [
        "sway/workspaces"
        "sway/window"
      ];
      center = ["clock"];
      right = [
        "network"
        "battery"
        "tray"
      ];
    };

    river = {
      left = [
        "river/tags"
        "river/window"
      ];
      center = ["clock"];
      right = [
        "network"
        "battery"
        "tray"
      ];
    };
  };

  currentModules = compositorModules.${cfg.compositor} or compositorModules.hyprland;
in {
  config = lib.mkIf cfg.enable {
    programs.waybar.settings = {
      mainBar =
        {
          layer = "top";
          position = "top";
          height = cfg.settings.height;
          spacing = cfg.settings.spacing;

          modules-left = currentModules.left;
          modules-center = currentModules.center;
          modules-right = currentModules.right;
        }
        // {
          clock = {
            tooltip-format = "<big>{:%Y %B}</big>\n<tt>{calendar}</tt>";
          };

          network = {
            format-wifi = "󰤨 {essid}";
            format-ethernet = "󰈀 {ipaddr}/{cidr}";
            format-disconnected = "󰤭 Offline";
            tooltip-format = "{ifname}: {ipaddr}";
          };

          battery = {
            format = "{icon} {capacity}%";
            format-icons = [
              "󰁺"
              "󰁻"
              "󰁼"
              "󰁽"
              "󰁾"
              "󰁿"
              "󰂀"
              "󰂁"
              "󰂂"
              "󰁹"
            ];
            format-charging = "󰂄 {capacity}%";
            format-plugged = "󰚥 {capacity}%";
          };

          tray = {
            spacing = 10;
          };
        };
    };
  };
}
