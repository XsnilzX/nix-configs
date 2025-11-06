{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./../share.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "nixes-test"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  fileSystems."/mnt/games" = {
    device = "/dev/disk/by-uuid/0597ed78-f294-469a-8d73-01b81a7573c3";
    fsType = "ext4";
    options = ["defaults"];
  };

  services = {
    desktopManager.plasma6.enable = true;

    displayManager.sddm.enable = true;

    displayManager.sddm.wayland.enable = true;
  };
}
