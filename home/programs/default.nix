{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./common.nix
    ./editor.nix
    ./email.nix
    ./git.nix
    ./media.nix
    ./terminal.nix
    ./writing.nix
  ];
}
