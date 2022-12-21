{
    description = "System flake configuration";
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager = {
              url = "github:nix-community/home-manager";
              inputs.nixpkgs.follows = "nixpkgs";
        };
    };
    outputs = { self, nixpkgs, home-manager }:
        let
            system = "x86_64-linux";
            pkgs = import nixpkgs {
                inherit system;
                config.allowUnfree = true;
            };
            lib = nixpkgs.lib;
        in {
            nixosConfigurations = {
                pluto = lib.nixosSystem {
                    inherit system;
                    modules = [ ./system/configuration.nix ];
                };
            };
            homeConfigurations = {
                pluto = home-manager.lib.homeManagerConfiguration {
                    inherit pkgs;
                    modules = [ ./home.nix ];
                };
            };
        };
}