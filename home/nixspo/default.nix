{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./ssh-nixspo.nix
  ];
  stylix = {
    targets.firefox.profileNames = ["default"];
    targets.zen-browser.profileNames = ["default"];
  };
}
