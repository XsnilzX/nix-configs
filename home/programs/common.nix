{
  lib,
  pkgs,
  ...
}: {
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
