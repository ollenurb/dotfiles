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
                inherit (nixpkgs) lib;
                inherit system inputs nixpkgs home-manager;
            };
        in {
            nixosConfigurations = {
                # Desktop PC
                pluto = import ./hosts/make-host.nix (commonInherits // {
                    host = "pluto";
                    stateVersion = "22.11";
                    hasBattery = false;
                    hdpi = true;
                });

                # Laptop (Thinkpad T470)
                lambda = (import ./hosts/make-host.nix (commonInherits // {
                    host = "lambda";
                    stateVersion = "22.11";
                    hasBattery = true;
                    hdpi = false;
                }));
            };
        };
}
