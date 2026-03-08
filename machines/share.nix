{
  config,
  lib,
  pkgs,
  inputs,
  machine,
  compositor,
  ...
}: {
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";
  i18n.supportedLocales = ["all"];

  services = {
    # Enable CUPS to print documents.
    printing = {
      enable = true;
      drivers = with pkgs; [
        brlaser # Open-Source Brother Treiber
        # oder:
        # brgenml1lpr
        # brgenml1cupswrapper
      ];
    };

    avahi = {
      enable = true;
      nssmdns4 = true;
    };

    pipewire = {
      enable = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };

    power-profiles-daemon.enable = true;
  };

  users.users.xsnilzx = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = ["wheel" "networkmanager" "docker"];
    packages = with pkgs; [
      tree
    ];
  };

  environment.systemPackages = with pkgs;
    [
      vim
      wget
      kdePackages.partitionmanager
      nh
      exfatprogs
      easyeffects
      wireguard-tools
    ]
    ++ lib.optionals (machine == "nixhael") [
      gamescope
    ];

  fonts = {
    enableDefaultPackages = true;
    fontconfig.enable = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only
      font-awesome
      libertine
      corefonts
    ];
  };

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];

      max-jobs = "auto";
      cores = 0;

      download-buffer-size = 268435456; # 256 MiB

      keep-outputs = true;
      keep-derivations = true;

      auto-optimise-store = true;
      sandbox = true;

      warn-dirty = false;
      builders-use-substitutes = true;

      substituters = ["https://cache.garnix.io"];

      trusted-substituters = [
        "https://cache.flox.dev"
      ];
      trusted-public-keys = [
        "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXtjlu/UaAZnotSH+zGeSHs="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      ];
    };
    gc = {
      automatic = lib.mkDefault true;
      dates = lib.mkDefault "weekly";
      options = lib.mkDefault "--delete-older-than 7d";
    };
  };

  programs = {
    gamemode.enable = true;

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    zsh.enable = true;

    niri.enable = lib.mkIf (compositor == "niri") true;

    gnome.gnome-keyring.enable = lib.mkIf (compositor == "niri") true; # secret service

    # Steam
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;

      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
  };

  virtualisation.docker.enable = true;

  # sudo-rs
  security = {
    sudo-rs = {
      enable = true;
      wheelNeedsPassword = true;
    };

    polkit.enable = lib.mkIf (compositor == "niri") true; # polkit

    pam.services.swaylock = lib.mkIf (compositor == "niri") {};
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  system.stateVersion = "25.05";
}
