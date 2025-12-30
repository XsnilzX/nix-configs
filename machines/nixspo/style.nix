{pkgs, ...}: {
  # STYLIX KONFIGURATION (Tokyo Night Dark)
  stylix = {
    enable = true;

    # Farb-Schema: Tokyo Night Dark aus den base16-schemes
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";

    # WICHTIG: Du musst ein Bild namens 'wallpaper.png' in deinem Flake-Ordner haben
    image = ./wallpaper.png;

    # Erzwingt Dark Mode
    polarity = "dark";

    # Deckkraft (Opacity) für Terminal etc. (optional)
    opacity = {
      applications = 1.0;
      terminal = 0.95;
      desktop = 1.0;
      popups = 1.0;
    };

    # Cursor Theme (Passt gut zu Tokyo Night)
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    # Fonts Konfiguration (Empfohlen für Icons im Terminal)
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sizes = {
        applications = 12;
        terminal = 14;
        desktop = 10;
        popups = 10;
      };
    };
  };
}
