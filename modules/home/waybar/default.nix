{
  config,
  lib,
  pkgs,
  compositor ? "hyprland",
  ...
}: let
  cfg = config.modules.waybar;
  stylixEnabled = config ? stylix && config.stylix.enable or false;
  supportedCompositors = [
    "hyprland"
    "niri"
    "sway"
    "river"
  ];

  validCompositor = lib.elem cfg.compositor supportedCompositors;
in {
  imports = [
    ./config.nix
    ./style.nix
    ./stylix.nix
    ./modules
  ];

  options.modules.waybar = {
    enable = lib.mkEnableOption "Waybar status bar";

    compositor = lib.mkOption {
      type = lib.types.enum supportedCompositors;
      default = compositor;
      description = "Compositor for workspace/window integration";
    };

    stylix = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = stylixEnabled;
      };
      targets.waybar = lib.mkOption {
        type = lib.types.bool;
        default = cfg.stylix.enable;
      };
    };

    theme = lib.mkOption {
      type = lib.types.enum ["dark"];
      default = "dark";
    };

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.waybar;
    };

    settings = {
      height = lib.mkOption {
        type = lib.types.int;
        default = 34;
      };
      spacing = lib.mkOption {
        type = lib.types.int;
        default = 8;
      };
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      assertions = [
        {
          assertion = validCompositor;
          message = "waybar: compositor '${cfg.compositor}' not supported. Use one of: ${toString supportedCompositors}";
        }
      ];

      home.packages = [cfg.package];

      programs.waybar = {
        enable = true;
        inherit (cfg) package;
        systemd.enable = true;
      };
    }

    (lib.mkIf (cfg.compositor == "niri") {
      programs.niri.settings.spawn-at-startup = lib.mkAfter [
        {command = ["systemctl" "--user" "start" "waybar.service"];}
      ];
    })

    (lib.mkIf cfg.stylix.enable {
      stylix.targets.waybar.enable = false;
    })
  ]);
}
