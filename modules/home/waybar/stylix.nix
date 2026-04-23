{
  config,
  lib,
  ...
}: let
  cfg = config.modules.waybar;
in {
  # Zusätzliche Stylix-spezifische Konfiguration
  config = lib.mkIf (cfg.enable && cfg.stylix.enable) {
    # Sicherstellen dass Stylix Waybar nicht doppelt konfiguriert
    stylix.targets.waybar.enable = false;

    # Waybar-spezifische Stylix-Anpassungen
    modules.waybar.settings = {
      # Höhe basierend auf Schriftgröße anpassen
      height = lib.mkDefault (config.stylix.fonts.sizes.popups * 2 + 8);
    };
  };
}
