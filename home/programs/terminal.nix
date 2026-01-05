{
  config,
  pkgs,
  ...
}: {
  # Terminal connfig
  programs = {
    #bash = {
    #  enable = true;
    #  shellAliases = {
    #    btw = "echo I use nixos, btw";
    #    ls = "eza -la --color=always --icons=always --hyperlink";
    #    nixrebuild = "sudo nixos-rebuild switch --flake ~/nix-configs#nixhael";
    #    nixupdate = "sudo nix flake update";
    #    code = "codium --ozone-platform=wayland";
    #  };
    #  bashrcExtra = "fastfetch";
    #};

    direnv = {
      enable = true;
      enableZshIntegration = true; # Hooked direkt in ZSH
      nix-direnv.enable = true; # Schnelleres Caching für Nix Shells
    };

    eza = {
      enable = true;
      enableZshIntegration = true;
      icons = "auto";
      git = true;
      extraOptions = ["--group-directories-first" "--header"];
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
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = ["--cmd cd"];
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        add_newline = false;
        # Deaktiviere langsame Module, wenn es hakt:
        # aws.disabled = true;
        # gcloud.disabled = true;
      };
    };
    uv.enable = true;
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      historySubstringSearch = {
        enable = true;
        searchUpKey = ["^[[A" "^[OA"];
        searchDownKey = ["^[[B" "^[OB"];
      };

      # Wir entfernen oh-my-zsh komplett für Speed und holen Funktionen einzeln:
      plugins = [
        {
          # Der bessere Ersatz für alias-tips (ist im offiziellen Repo!)
          name = "zsh-you-should-use";
          src = pkgs.zsh-you-should-use;
          file = "share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh";
        }
        {
          name = "zsh-nix-shell";
          file = "nix-shell.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "chisui";
            repo = "zsh-nix-shell";
            rev = "v0.8.0";
            sha256 = "Z6EYQdasvpl1P78poj9efnnLj7QQg13Me8x1Ryyw+dM=";
          };
        }
      ];

      # Eigene Aliases (Ersetzt das git-plugin von OMZ)
      shellAliases = {
        # Modern replacements
        ls = "eza -la --color=always --icons=always --hyperlink";
        ll = "eza -lah --icons --git";
        grep = "rg";
        cat = "bat --style=plain --paging=never";

        # Git (Die wichtigsten von OMZ)
        g = "git";
        ga = "git add";
        gaa = "git add --all";
        gst = "git status";
        gc = "git commit -m";
        gp = "git push";
        gl = "git pull";
        gll = "git pull -f";
        gco = "git checkout";
        gsw = "git switch";

        # System
        rebuild = "sudo nixos-rebuild switch --flake .";
        code = "codium --ozone-platform=wayland";
      };

      # Umgebungsvariablen & Init
      initContent = ''
        # 1. Farbige Manpages (Ersetzt das OMZ Plugin ohne Performance-Verlust)
        export LESS_TERMCAP_mb=$'\e[1;32m'
        export LESS_TERMCAP_md=$'\e[1;32m'
        export LESS_TERMCAP_me=$'\e[0m'
        export LESS_TERMCAP_se=$'\e[0m'
        export LESS_TERMCAP_so=$'\e[01;33m'
        export LESS_TERMCAP_ue=$'\e[0m'
        export LESS_TERMCAP_us=$'\e[1;4;31m'
        export MANPAGER="sh -c 'col -bx | bat -l man -p'"

        # 2. Settings
        setopt inc_append_history
        setopt share_history
        setopt hist_ignore_all_dups

        # 3. Keybindings fixen (Falls nötig)
        bindkey '^[[H' beginning-of-line
        bindkey '^[[F' end-of-line
        bindkey '^?' backward-delete-char

        # Fastfetch interaktiv
        if [[ $- == *i* ]]; then
         command -v fastfetch >/dev/null 2>&1 && fastfetch
        fi
      '';
    };
  };
}
