{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./../share.nix
    ./../../modules/sops/nixhael.nix
  ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-zen4;

    kernelParams = [
      "amd_pstate=active"
    ];

    kernel.sysctl = {
      "vm.swappiness" = 10;
      "kernel.sched_autogroup_enabled" = 1;
    };
  };

  powerManagement.cpuFreqGovernor = "performance";

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  environment.variables = {
    AMD_VULKAN_ICD = "RADV";
  };

  nixpkgs.config.allowUnfree = true;
  #nixpkgs.overlays = [nix-cachyos-kernel.overlays.pinned];

  networking.hostName = "nixhael"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  fileSystems."/mnt/games" = {
    device = "/dev/disk/by-uuid/0597ed78-f294-469a-8d73-01b81a7573c3";
    fsType = "ext4";
    options = ["defaults"];
  };

  services = {
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = true;
        KbdInteractiveAuthentication = false;
        X11Forwarding = false;
      };
    };

    desktopManager.plasma6.enable = true;

    displayManager.sddm.enable = true;

    displayManager.sddm.wayland.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
