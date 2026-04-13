{
  lib,
  pkgs,
  machine,
  compositor,
  ...
}: {
  imports = [
    ../modules/luh-vpn.nix
  ];

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

    mullvad-vpn.enable = true;

    pipewire = {
      enable = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };

    power-profiles-daemon.enable = true;
    gnome.gnome-keyring.enable = lib.mkIf (compositor == "niri") true; # secret service
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

      substituters = [
        "https://cache.garnix.io"
        "https://cache.nixos.org/"
        "https://xsnilzx.cachix.org"
      ];

      trusted-substituters = [
        "https://attic.xuyh0120.win/lantian"
        "https://cache.nixos.org/"
        "https://xsnilzx.cachix.org"
      ];

      trusted-public-keys = [
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
        "xsnilzx.cachix.org-1:Sxn4bw0QwjTLqFcK5esmKsXR3NDPi1Wr2ZhOiGcJDjc="
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

  hardware.bluetooth.enable = true;

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
