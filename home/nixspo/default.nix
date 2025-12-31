{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./ssh-nixspo.nix
  ];
  stylix = {
    targets.firefox.profileNames = ["default"];
    targets.zen-browser.profileNames = ["default"];
  };

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };

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
