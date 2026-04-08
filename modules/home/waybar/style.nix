{
  config,
  lib,
  ...
}: let
  cfg = config.modules.waybar;
  stylixEnabled = config ? stylix && config.stylix.enable or false;

  hexPairToDec = pair: (builtins.fromTOML "value = 0x${pair}").value;

  hexToRgb = hex: let
    normalized = lib.removePrefix "#" hex;
  in "${toString (hexPairToDec (lib.substring 0 2 normalized))}, ${toString (hexPairToDec (lib.substring 2 2 normalized))}, ${toString (hexPairToDec (lib.substring 4 2 normalized))}";

  colors =
    if stylixEnabled
    then {
      bg = config.lib.stylix.colors.base00;
      bg-alt = config.lib.stylix.colors.base01;
      fg = config.lib.stylix.colors.base05;
      fg-alt = config.lib.stylix.colors.base04;
      accent = config.lib.stylix.colors.base0D;
      urgent = config.lib.stylix.colors.base08;
      success = config.lib.stylix.colors.base0B;
      warning = config.lib.stylix.colors.base0A;
    }
    else let
      manualThemes = {
        dark = {
          bg = "1e1e2e";
          bg-alt = "313244";
          fg = "cdd6f4";
          fg-alt = "a6adc8";
          accent = "89b4fa";
          urgent = "f38ba8";
          success = "a6e3a1";
          warning = "f9e2af";
        };
      };
    in
      manualThemes.${cfg.theme};

  font =
    if stylixEnabled
    then {
      name = config.stylix.fonts.sansSerif.name;
      size = config.stylix.fonts.sizes.popups;
    }
    else {
      name = "JetBrainsMono Nerd Font";
      size = 13;
    };

  borderRadius =
    if stylixEnabled
    then config.stylix.roundness or 0
    else 0;
in {
  config = lib.mkIf cfg.enable {
    programs.waybar.style = ''
      * {
        font-family: "${font.name}", sans-serif;
        font-size: ${toString font.size}px;
        min-height: 0;
      }

      window#waybar {
        background-color: #${colors.bg};
        color: #${colors.fg};
        border-radius: ${toString borderRadius}px;
      }

      ${lib.optionalString stylixEnabled ''
        window#waybar {
          background-color: rgba(${hexToRgb colors.bg}, ${toString (config.stylix.opacity.popups or 1.0)});
        }
      ''}

      #workspaces button {
        padding: 0 10px;
        color: #${colors.fg};
        border-radius: ${toString borderRadius}px;
      }

      #workspaces button:hover {
        background: #${colors.accent};
        color: #${colors.bg};
      }

      #workspaces button.focused,
      #workspaces button.active {
        background-color: #${colors.accent};
        color: #${colors.bg};
      }

      #workspaces button.urgent {
        background-color: #${colors.urgent};
      }

      #clock,
      #battery,
      #network,
      #tray,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #backlight,
      #pulseaudio,
      #custom-media {
        padding: 0 12px;
        margin: 4px 2px;
        color: #${colors.fg};
        background-color: #${colors.bg-alt};
        border-radius: ${toString borderRadius}px;
      }

      #clock {
        background-color: #${colors.accent};
        color: #${colors.bg};
      }

      #battery.critical,
      #temperature.critical {
        background-color: #${colors.urgent};
        color: #${colors.bg};
      }

      #battery.warning,
      #temperature.warning {
        background-color: #${colors.warning};
        color: #${colors.bg};
      }

      #battery.charging {
        background-color: #${colors.success};
        color: #${colors.bg};
      }

      tooltip {
        background-color: #${colors.bg};
        border: 1px solid #${colors.accent};
        border-radius: ${toString borderRadius}px;
      }

      tooltip label {
        color: #${colors.fg};
      }
    '';
  };
}
