{ config, pkgs, lib, machine, ... }:

{
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
    age
  ]
  ++ lib.optionals (machine == "nixspo") [
    brightnessctl
  ]
  ++ lib.optionals (machine == "nixhael") [
    # Optional
  ];
}
