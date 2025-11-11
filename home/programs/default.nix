{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./common.nix
    ./editor.nix
    ./git.nix
    ./media.nix
    ./terminal.nix
  ];
}
