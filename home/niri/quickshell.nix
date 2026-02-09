{
  config,
  pkgs,
  ...
}: {
  programs.myQuickshell = {
    enable = true;
    autoStart = true;
    workspaceBackend = "niri";
    startNmApplet = false;
    startBluemanApplet = false;
    enableGoather = true;

    # Optional override (default comes from input goather = github:XsnilzX/goather)
    # goatherPackage = inputs.goather.packages.${pkgs.system}.default;
  };
}
