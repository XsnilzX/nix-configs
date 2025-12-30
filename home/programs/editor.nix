{
  pkgs,
  lib,
  ...
}: {
  # Editor Setup

  programs.helix = {
    enable = true;
    settings = {
      theme = lib.mkForce "dracula_at_night";
      editor = {
        scrolloff = 8;
        scroll-lines = 4;
        line-number = "relative";
        auto-format = false;
      };
      editor.statusline = {
        left = ["mode" "spinner"];
        center = ["file-name"];
        right = ["diagnostics" "selections" "position" "file-encoding" "file-line-ending" "file-type"];
        separator = "│";
        mode.normal = "NORMAL";
        mode.insert = "INSERT";
        mode.select = "SELECT";
        diagnostics = ["warning" "error"];
        workspace-diagnostics = ["warning" "error"];
      };
      editor.lsp = {
        display-messages = true;
      };
    };
    languages = {
      language = [
        {
          name = "rust";
          auto-fortmat = true;
        }
      ];
      language-server.rust-analyzer = with pkgs.rust-analyzer; {
        command = "rust-analyzer";
      };
      #language = [{
      #	name = "typst";
      #	language-server = "tinymist";
      #}];
      #language-server.tinymist = with pkgs.tinymist; {
      #	command = "tinymist";
      #};
    };
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    mutableExtensionsDir = false;
    profiles.default = {
      extensions = with pkgs.vscode-extensions;
        [
          pkief.material-icon-theme
          # editorconfig.editorconfig
          esbenp.prettier-vscode
          redhat.java
          llvm-vs-code-extensions.vscode-clangd
          rust-lang.rust-analyzer
          ms-python.python
          continue.continue
          tomoki1207.pdf
          jnoortheen.nix-ide
        ]
        ++ (with pkgs.vscode-marketplace; [
          # Extensions, die nicht in den offiziellen pkgs sind, kommen hier rein:
          vmware.vscode-spring-boot
        ]);

      # Extensions aktivieren
      userSettings = {
        "workbench.iconTheme" = "material-icon-theme";
        "editor.formatOnSave" = true;
        "nix.formatterPath" = "${pkgs.alejandra}/bin/alejandra";
      };
    };
  };

  programs.zed-editor = {
    enable = true;
    extensions = ["nix" "dracula" "typst"];
  };
}
