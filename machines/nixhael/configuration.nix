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
    ./../../modules/sops/nixhael.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.kernelParams = [
    "amd_pstate=active"
  ];

  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
    "kernel.sched_autogroup_enabled" = 1;
  };

  powerManagement.cpuFreqGovernor = "performance";

  programs.gamemode.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    extraPackages = with pkgs; [
      mesa
      vulkan-loader
      vulkan-tools
      vulkan-validation-layers
    ];
  };

  environment.variables = {
    RADV_PERFTEST = "aco";
    AMD_VULKAN_ICD = "RADV";
    MANGOHUD = "0";
  };

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "nixhael"; # Define your hostname.
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
