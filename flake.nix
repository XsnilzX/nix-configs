{
  description = "My own Nix-OS Flake config.";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    flox.url = "github:flox/flox";
    helium = {
      url = "github:AlvaroParker/helium-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri.url = "github:sodiboo/niri-flake";
    nix-cachyos-kernel = {
      url = "github:xddxdd/nix-cachyos-kernel";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    my-quickshell.url = "github:XsnilzX/my-quickshell";
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.noctalia-qs.follows = "noctalia-qs";
    };
    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nix-vscode-extensions,
    nix-cachyos-kernel,
    home-manager,
    sops-nix,
    stylix,
    my-quickshell,
    ...
  }: let
    myOverlay = final: prev: {
      helium = inputs.helium.packages.${prev.stdenv.hostPlatform.system}.default;
    };
  in {
    nixosConfigurations = {
      nixhael = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          machine = "nixhael";
          compositor = "kde";
          inherit self inputs;
        };
        modules = [
          ./machines/nixhael/configuration.nix
          sops-nix.nixosModules.sops
          stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
          {
            nixpkgs.config.allowUnfree = true;
            nixpkgs.overlays = [nix-vscode-extensions.overlays.default nix-cachyos-kernel.overlays.pinned myOverlay];
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.xsnilzx = import ./home/home.nix;
              backupFileExtension = "backup";
              extraSpecialArgs = {
                machine = "nixhael";
                compositor = "kde";
                inherit inputs;
              };
            };
          }
        ];
      };

      nixspo = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          machine = "nixspo";
          compositor = "niri";
          inherit self inputs;
        };
        modules = [
          ./machines/nixspo/configuration.nix
          sops-nix.nixosModules.sops
          stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
          {
            nixpkgs.config.allowUnfree = true;
            nixpkgs.overlays = [nix-vscode-extensions.overlays.default nix-cachyos-kernel.overlays.pinned myOverlay];
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              sharedModules = [my-quickshell.homeManagerModules.default];
              users.xsnilzx = import ./home/home.nix;
              backupFileExtension = "backup";
              extraSpecialArgs = {
                machine = "nixspo";
                compositor = "niri";
                inherit inputs;
              };
            };
          }
        ];
      };
    };
  };
}
