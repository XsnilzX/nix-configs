{
  config,
  lib,
  pkgs,
  inputs,
  machine,
  ...
}: {
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";
  i18n.supportedLocales = ["all"];

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      brlaser # Open-Source Brother Treiber
      # oder:
      # brgenml1lpr
      # brgenml1cupswrapper
    ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
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

  services.power-profiles-daemon.enable = true;

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

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  virtualisation.docker.enable = true;

  # sudo-rs
  security.sudo-rs = {
    enable = true;
    wheelNeedsPassword = true;
  };

  #nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  programs.zsh.enable = true;

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;

    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  system.stateVersion = "25.05";
}
