{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./ssh-nixspo.nix
  ];

  home.sessionVariables = {
    SAL_USE_VCLPLUGIN = "gtk4";

    XCURSOR_SIZE = "${toString config.stylix.cursor.size}";
    XCURSOR_THEME = "${config.stylix.cursor.name}";
  };

  stylix = {
    icons = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };

    targets = {
      gtk.enable = true;
      firefox.profileNames = ["default"];
      vscode = {
        enable = true;
        profileNames = ["default" "Python" "Nix-OS" "Java" "Quickshell" "Typst"];
      };
      zen-browser.profileNames = ["default"];
      zed.enable = true;
    };
  };

  gtk = {
    enable = true;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
