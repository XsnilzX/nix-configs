{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    # Für C/C++
    clang-tools
    gcc
    # Rust (cargo ist meistens via rustup oder rustc da, aber rust-analyzer wird gebraucht)
    rust-analyzer
    # Go
    gopls
    (lib.lowPrio gotools) # für gofumpt/goimports
    # Typst
    tinymist
    # Java
    jdt-language-server
  ];

  programs = {
    helix = {
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
          mode = {
            normal = "NORMAL";
            insert = "INSERT";
            select = "SELECT";
          };
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
            name = "c";
            auto-format = true;
            language-servers = ["clangd"];
          }
          {
            name = "cpp";
            auto-format = true;
            language-servers = ["clangd"];
          }
          {
            name = "rust";
            auto-format = true;
          }
          {
            name = "typst";
            language-servers = ["tinymist"];
          }
          {
            name = "go";
            language-servers = ["gopls"];
          }
          {
            name = "java";
            language-servers = ["jdtls"];
          }
          {
            name = "nix";
            auto-format = true;
            language-servers = ["nixd"];
            formatter = {
              command = "${pkgs.alejandra}/bin/alejandra";
            };
          }
        ];
        language-server = {
          clangd = {
            command = "clangd";
            # Nützliche Argumente für clangd
            args = [
              "--background-index"
              "--clang-tidy"
              "--header-insertion=iwyu"
              "--completion-style=detailed"
              "--function-arg-placeholders"
              "--fallback-style=llvm"
            ];
          };
          gopls = {
            command = "gopls";
            args = ["-logfile=/tmp/gopls.log" "serve"];
            config = {
              "ui.diagnostic.staticcheck" = false;
              gofumpt = true;
            };
          };
          jdtls = {
            command = "jdtls";
          };
          rust-analyzer = {
            command = "rust-analyzer";
          };
          tinymist = {
            command = "${pkgs.tinymist}/bin/tinymist";
          };
          nixd = {
            command = "${pkgs.nixd}/bin/nixd";
          };
        };
      };
    };

    vscode = {
      enable = true;
      package = pkgs.vscodium;
      mutableExtensionsDir = false;
      profiles = {
        default = {
          extensions = with pkgs.vscode-extensions;
            [
              pkief.material-icon-theme
              # editorconfig.editorconfig
              esbenp.prettier-vscode
              # llvm-vs-code-extensions.vscode-clangd
              # rust-lang.rust-analyzer
              # ms-python.python
              continue.continue
              tomoki1207.pdf
              jnoortheen.nix-ide
              #redhat.java
            ]
            ++ (with pkgs.vscode-marketplace; [
              # Extensions, die nicht in den offiziellen pkgs sind, kommen hier rein:
            ]);

          # Extensions aktivieren
          userSettings = {
            "workbench.iconTheme" = "material-icon-theme";
            "editor.formatOnSave" = true;
            "nix.formatterPath" = "${pkgs.alejandra}/bin/alejandra";
            "git.autofetch" = true;
            "git.confirmSync" = false;
            "window.newWindowProfile" = "Default";
          };
        };
        "Python" = {
          extensions = with pkgs.vscode-extensions;
            [
              pkief.material-icon-theme
              esbenp.prettier-vscode
              ms-python.python
              continue.continue
              tomoki1207.pdf
            ]
            ++ (with pkgs.vscode-marketplace; [
              # Extensions, die nicht in den offiziellen pkgs sind, kommen hier rein:
              the0807.uv-toolkit
            ]);
          userSettings = {
            "workbench.iconTheme" = "material-icon-theme";
            "editor.formatOnSave" = true;
            "git.autofetch" = true;
            "git.confirmSync" = false;
          };
        };
        "Nix-OS" = {
          extensions = with pkgs.vscode-extensions;
            [
              pkief.material-icon-theme
              # editorconfig.editorconfig
              esbenp.prettier-vscode
              continue.continue
              tomoki1207.pdf
              jnoortheen.nix-ide
              signageos.signageos-vscode-sops
            ]
            ++ (with pkgs.vscode-marketplace; [
              # Extensions, die nicht in den offiziellen pkgs sind, kommen hier rein:
            ]);

          # Extensions aktivieren
          userSettings = {
            "workbench.iconTheme" = "material-icon-theme";
            "editor.formatOnSave" = true;
            "nix.formatterPath" = "${pkgs.alejandra}/bin/alejandra";
            "git.autofetch" = true;
            "git.confirmSync" = false;
          };
        };

        "Java" = {
          extensions = with pkgs.vscode-extensions;
            [
              pkief.material-icon-theme
              esbenp.prettier-vscode
              continue.continue
              tomoki1207.pdf
              redhat.java
            ]
            ++ (with pkgs.vscode-marketplace; [
              # Extensions, die nicht in den offiziellen pkgs sind, kommen hier rein:
            ]);

          # Extensions aktivieren
          userSettings = {
            "workbench.iconTheme" = "material-icon-theme";
            "editor.formatOnSave" = false;
            "redhat.telemetry.enabled" = false;
            "git.autofetch" = true;
            "git.confirmSync" = false;
          };
        };

        "Typst" = {
          extensions = with pkgs.vscode-extensions; [
            pkief.material-icon-theme
            esbenp.prettier-vscode
            continue.continue
            tomoki1207.pdf
            myriad-dreamin.tinymist
          ];

          userSettings = {
            "workbench.iconTheme" = "material-icon-theme";
            "editor.formatOnSave" = true;
            "git.autofetch" = true;
            "git.confirmSync" = false;
          };
        };

        "Rust" = {
          extensions = with pkgs.vscode-extensions; [
            pkief.material-icon-theme
            continue.continue
            tomoki1207.pdf
            # Rust stuff
            rust-lang.rust-analyzer
            fill-labs.dependi
            tamasfe.even-better-toml
            nefrob.vscode-just-syntax
          ];

          userSettings = {
            "workbench.iconTheme" = "material-icon-theme";
            "editor.formatOnSave" = true;
            "git.autofetch" = true;
            "git.confirmSync" = false;
            "telemetry.telemetryLevel" = "off";
          };
        };

        "Go" = {
          extensions = with pkgs.vscode-extensions; [
            pkief.material-icon-theme
            esbenp.prettier-vscode
            continue.continue
            golang.go
            usernamehw.errorlens
          ];

          userSettings = {
            "workbench.iconTheme" = "material-icon-theme";
            "editor.formatOnSave" = true;
            "git.autofetch" = true;
            "git.confirmSync" = false;
            "go.useLanguageServer" = true;
            "go.lintTool" = "golangci-lint";
            "go.formatTool" = "goimports";
            "gopls" = {
              "ui.semanticTokens" = true;
              "formatting.gofumpt" = true;
            };
          };
        };

        "C-C++" = {
          extensions = with pkgs.vscode-extensions; [
            pkief.material-icon-theme
            esbenp.prettier-vscode
            llvm-vs-code-extensions.vscode-clangd
          ];

          userSettings = {
            "workbench.iconTheme" = "material-icon-theme";
            "editor.formatOnSave" = true;
            "git.autofetch" = true;
            "git.confirmSync" = false;
          };
        };
      };
    };

    zed-editor = {
      enable = true;
      extensions = ["nix" "typst" "java" "toml"];
      userSettings = {
        auto_update = false;

        assistant = {
          enabled = true;
          provider = "openai";
        };

        telemetry = {
          diagnostic = false;
          metrics = false;
        };

        format_on_save = true;
        git.auto_fetch = true;

        languages = {
          Java.lsp.command = "jdtls";

          JavaScript = {
            formatter = "prettier";
          };

          Nix = {
            formatter = {
              external = {
                command = "${pkgs.alejandra}/bin/alejandra";
                arguments = ["-"];
              };
            };
          };

          Python.formatter = "black";

          TypeScript = {
            formatter = "prettier";
          };
        };
      };
    };
  };
}
