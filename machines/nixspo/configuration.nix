{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./style.nix
    ./../share.nix
    ./../../modules/hyprland.nix
    ./../../modules/sops/nixspo.nix
    ./../../modules/eduroam.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "nixspo";
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;

  services = {
    udisks2.enable = true;
    openssh.enable = true;
  };
}
