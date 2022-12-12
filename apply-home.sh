#!/bin/sh
pushd ~/.dotfiles
nix build .#homeConfigurations.pluto.activationPackage
./result/activate
popd
