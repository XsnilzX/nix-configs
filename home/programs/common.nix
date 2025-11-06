{lib,pkgs, ...}: {
  home.packages = with pkgs; [
    # archives
    zip
    unzip
    p7zip

    # utils
    libnotify
    xdg-utils
    amdgpu_top
    htop
    fastfetch

    # gaming tools
    protonplus
    discord

    # nix ide
    alejandra
    nixd
  ];

  programs = {
    btop.enable = true;
    eza.enable = true;
    ssh = {
      enable = true;
      matchBlocks = {
        # add all hosts
      };
    };
  };

  services = {
    udiskie.enable = true;
  };
}