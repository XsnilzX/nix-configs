{
  pkgs,
  lib,
  machine,
  compositor,
  weatherWidgetPath,
  ...
}: let
  # Wrapper mit allen benötigten Libraries
  weatherWidget = pkgs.writeShellScriptBin "weather-widget" ''
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [
      pkgs.stdenv.cc.cc.lib
      pkgs.zlib
    ]}"

    cd "${weatherWidgetPath}"
    exec ${pkgs.uv}/bin/uv run main.py "$@"
  '';
in {
  home.sessionVariables = {
    UV_PYTHON_PREFERENCE = "only-system";
    NIXOS_OZONE_WL = "1";
  };

  home.packages = with pkgs;
    [
      # archives
      zip
      unzip
      p7zip

      # utils
      libnotify
      xdg-utils
      amdgpu_top
      fastfetch
      seafile-client
      ncdu
      fd
      ripgrep
      bat
      gimp
      qbittorrent
      geogebra6

      # VPN
      mullvad-vpn
      protonvpn-gui

      # Chatting
      element-desktop
      discord

      prismlauncher
      lunar-client
      helium

      # nix ide
      alejandra
      nixd
      age
      sops

      # Coding
      uv
      stdenv.cc.cc.lib
      python313

      # Nix tools
      devbox
      direnv
      nix-direnv
    ]
    ++ lib.optionals (machine == "nixspo") [
      brightnessctl
      weatherWidget
      xarchiver
      pavucontrol
      networkmanagerapplet
      blueman
    ]
    ++ lib.optionals (machine == "nixspo" && compositor == "hyprland") [
      hyprpaper
    ]
    ++ lib.optionals (machine == "nixspo" && compositor == "niri") [
      xwayland-satellite
    ]
    ++ lib.optionals (machine == "nixhael") [
      heroic
      mangohud
      goverlay
      protonplus
    ];

  xdg.desktopEntries.discord = {
    name = "Discord";
    genericName = "All-in-one voice and text chat";
    exec = "discord --ozone-platform=wayland";
    icon = "discord";
    type = "Application";
    categories = ["Network" "InstantMessaging"];
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
