{
  lib,
  pkgs,
  compositor,
  ...
}: {
  imports =
    [
      ./hardware-configuration.nix
      ./style.nix
      ./../share.nix
      ./../../modules/sops/nixspo.nix
      ./../../modules/eduroam.nix
    ]
    ++ lib.optionals (compositor == "niri") [
      ./../../modules/niri.nix
    ]
    ++ lib.optionals (compositor == "hyprland") [
      ./../../modules/hyprland.nix
    ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    kernelPackages = pkgs.linuxPackages_latest;
  };

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "nixspo";
  networking.networkmanager.enable = true;

  services = {
    udisks2.enable = true;
    openssh.enable = true;
    upower.enable = true;
  };
}
