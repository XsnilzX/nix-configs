{
  config,
  pkgs,
  ...
}: {
  # Terminal connfig
  programs = {
    bash = {
      enable = true;
      shellAliases = {
        btw = "echo I use nixos, btw";
        ls = "eza -la --color=always --icons=always --hyperlink";
        nixrebuild = "sudo nixos-rebuild switch --flake ~/nix-configs#nixes-test";
        nixupdate = "sudo nix flake update";
      };
    };
    ghostty = {
      enable = true;
      settings = {
        theme = "Dracula";
        font-size = 12;
        font-family = "JetBrainsMono Nerd Font Mono";
        background-opacity = 0.6;
      };
    };
  };
}
