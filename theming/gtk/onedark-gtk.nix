{ pkgs, lib, stdenv, fetchzip }:

stdenv.mkDerivation rec {
  pname = "adwaita-one-dark-gtk";
  version = "v40-shell.0";

  src = fetchzip {
    name = "adwaita-one-dark";
    url = "https://github.com/lonr/adwaita-one-dark/releases/download/${version}/Adwaita-One-Dark.zip";
    sha256 = "1xq6mw1lan92w466b36hazmz7wmv7qvypm71jgccxlzi7fgv46gc";
  };

  sourceRoot = ".";

  propagatedUserEnvPkgs = [ pkgs.gtk-engine-murrine ];

  installPhase = ''
    mkdir -p $out/share/themes/
    cp adwaita-one-dark $out/share/themes/ -r
  '';

}


