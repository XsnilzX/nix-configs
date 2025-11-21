{
  inputs,
  lib,
  machine,
  config,
  pkgs,
  ...
}: {
  home.username = "xsnilzx";
  home.homeDirectory = "/home/xsnilzx";
  home.stateVersion = "25.05";

  imports =
    [
      inputs.zen-browser.homeModules.twilight
      ./programs
    ]
    ++ lib.optionals (machine == "nixspo") [./hyprland ./niri];
  programs.zen-browser = {
    enable = true;
    languagePacks = ["de" "en-US"];
  };

  home.packages = [
    inputs.helium.packages.${pkgs.system}.default
  ];

  programs.firefox = {
    enable = true;
    languagePacks = ["de"];
    policies = {
      ShowHomeButton = true;
      DefaultDownloadDirectory = "${config.home.homeDirectory}/Downloads";
      DisableTelemetry = true;
      ExtensionSettings = {
        "Bitwarden" = {
          default_area = "menupanel";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
      };
    };
  };

  services.ollama = {
    enable = true;
    acceleration = "rocm";
  };
}
