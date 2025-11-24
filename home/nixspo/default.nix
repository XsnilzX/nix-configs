{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./ssh-nixspo.nix
  ];
}
