{
  description = "nixes-test";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    helium = {
      url = "github:AlvaroParker/helium-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    sops-nix,
    ...
  }: {
    # Definieren der Maschinen-Konfigurationen
    nixosConfigurations = {
      nixes-test = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          machine = "nixhael";
          inherit self inputs;
        };
        modules = [
          ./machines/nixhael/configuration.nix
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager
          {
            nixpkgs.config.allowUnfree = true;
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.xsnilzx = import ./home/home.nix;
              backupFileExtension = "backup";
              extraSpecialArgs = {
                machine = "nixhael";
                inherit inputs;
              };
            };
          }
        ];
      };

      nixel = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          machine = "nixspo";
          inherit self inputs;
        };
        modules = [
          ./machines/nixspo/configuration.nix
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager
          {
            nixpkgs.config.allowUnfree = true;
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.xsnilzx = import ./home/home.nix;
              backupFileExtension = "backup";
              extraSpecialArgs = {
                machine = "nixspo";
                inherit inputs;
              };
            };
          }
        ];
      };
    };
  };
}
