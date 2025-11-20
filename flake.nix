{
  description = "nixes-test";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    helium = {
      url = "github:AlvaroParker/helium-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
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
    ...
  }: {
    # Definieren der Maschinen-Konfigurationen
    nixosConfigurations = {
      nixes-test = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          machine = "nixes-test";
          inherit self inputs;
        };
        modules = [
          ./machines/nix-test/configuration.nix
          home-manager.nixosModules.home-manager
          {
            nixpkgs.config.allowUnfree = true;
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.xsnilzx = import ./home/home.nix;
              backupFileExtension = "backup";
              extraSpecialArgs = {
                machine = "nixes-test";
                inherit inputs;
              };
            };
          }
        ];
      };

      nixel = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          machine = "nixel";
          inherit self inputs;
        };
        modules = [
          ./machines/nixel/configuration.nix
          home-manager.nixosModules.home-manager
          {
            nixpkgs.config.allowUnfree = true;
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.xsnilzx = import ./home/home.nix;
              backupFileExtension = "backup";
              extraSpecialArgs = {
                machine = "nixel";
                inherit inputs;
              };
            };
          }
        ];
      };
    };
  };
}
