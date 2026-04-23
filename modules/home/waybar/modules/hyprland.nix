{
  config,
  lib,
  ...
}: let
  cfg = config.modules.waybar;
  isHyprland = cfg.compositor == "hyprland";
in {
  options.modules.waybar.modules.hyprland = {
    workspaces = {
      enable =
        lib.mkEnableOption "Hyprland workspaces"
        // {
          default = isHyprland;
        };

      format = lib.mkOption {
        type = lib.types.str;
        default = "{name}";
        description = "Workspace format";
      };
    };

    window = {
      enable =
        lib.mkEnableOption "Hyprland window title"
        // {
          default = isHyprland;
        };

      max-length = lib.mkOption {
        type = lib.types.int;
        default = 50;
      };
    };
  };

  config = lib.mkIf (cfg.enable && isHyprland) {
    programs.waybar.settings.mainBar = lib.mkMerge [
      (lib.mkIf cfg.modules.hyprland.workspaces.enable {
        "hyprland/workspaces" = {
          inherit (cfg.modules.hyprland.workspaces) format;
          on-click = "activate";
          sort-by-number = true;
        };
      })

      (lib.mkIf cfg.modules.hyprland.window.enable {
        "hyprland/window" = {
          inherit (cfg.modules.hyprland.window) max-length;
          separate-outputs = true;
        };
      })
    ];
  };
}
