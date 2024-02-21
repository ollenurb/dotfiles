{
    description = "NixOS system configurations";
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };
    outputs = inputs@ { self, nixpkgs, home-manager, ... }:
        let
            system = "x86_64-linux";
            commonInherits = {
                inherit system inputs nixpkgs home-manager;
            };
        in {
            nixosConfigurations = {
                # Desktop PC
                pluto = import ./hosts/make-host.nix (commonInherits // {
                    host = "pluto";
                });

                # Laptop (Thinkpad T470)
                lambda = (import ./hosts/make-host.nix (commonInherits // {
                    host = "lambda";
                }));
            };
        };
}
