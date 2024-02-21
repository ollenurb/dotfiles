# Nix derivation that builds a single host
{ lib, inputs, system, nixpkgs, home-manager, host, stateVersion, hasBattery, ... }:

let
    # Define a single user for home-manager
    user = "matteo";

    # Define and configure nixkpgs
    pkgs = import nixpkgs {
        inherit system;
        config = {
            allowUnfree = true;
            allowBroken = true;
            allowUnsupportedSystem = true;
        };
        # Add overlays if you want
        # overlays = [];
    };

    # Define extra arguments
    extraArgs = { inherit pkgs system stateVersion hasBattery inputs host user; };
in
# Actually define the nixos system
nixpkgs.lib.nixosSystem
    {
        inherit system;
        specialArgs = extraArgs;
        modules = [
            ./${host}/system.nix
            ./${host}/hardware.nix
            home-manager.nixosModules.home-manager {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = extraArgs;
                home-manager.users.${user} = {
                    imports = [ ./${host}/home.nix ];
                };
            }
        ];
    }
