{
  config,
  pkgs,
  lib,
  machine,
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
      htop
      fastfetch
      seafile-client

      # gaming tools
      protonplus
      discord

      # nix ide
      alejandra
      nixd
      age
      sops

      # Coding
      uv
      stdenv.cc.cc.lib
      python313
    ]
    ++ lib.optionals (machine == "nixspo") [
      brightnessctl
      weatherWidget
      xarchiver
    ]
    ++ lib.optionals (machine == "nixhael") [
      # Optional
    ];
}
