{ config, lib, pkgs, stdenv, ... }:

let
  programs = with pkgs; [
    nix-doc            		      # nix documentation search tool
    pavucontrol        		      # pulseaudio control
    firefox            		      # browser
    spotify                           # Music player
    feh                               # Image viewer
    tdesktop                          # Telegram
    mpv                               # Video Player
    rofi-power-menu                   # Power menu
  ];

  tools = with pkgs; [
    pandoc                            # Documents generator
  ];

  utilities = with pkgs; [
    entr                              # utility that watch for file changes
    ripgrep                           # faster grep
    htop                              # better top
    killall              	      # kill all processes
    duf                 	      # disk usage/free utility
    fd                  	      # "find" for files
    fzf                               # fuzzy finder
    exa                		      # a better ls
    libnotify          		      # notify-send command
    gnumake                           # Make utility
  ];

  haskellPkgs = with pkgs.haskellPackages; [
    brittany                          # code formatter
    cabal-install                     # cabal
    ghc                               # compiler
    haskell-language-server           # hls
  ];

in {
  home = {
    username = "matteo";
    homeDirectory = "/home/matteo";
    packages = programs ++ utilities;
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  # Change GTK theme
  gtk = {
    enable = true;
    theme = {
      package = pkgs.callPackage ./theming/gtk/onedark-gtk.nix { };
      name = "adwaita-one-dark";
    };
    iconTheme = {
      package = pkgs.gruvbox-dark-icons-gtk;
      name = "oomox-gruvbox-dark";
    };
  };

  imports =
    (import ./programs) ++
    (import ./shell) ++
    [(import ./theming/onedark.nix)];

  programs = {
    bat.enable = true;
    git = {
      enable = true;
      userName = "Ollenurb";
      userEmail = "brunello.mtt@gmail.com";
      extraConfig = {
        core.editor = "nvim";
        init.defaultBranch = "main";
      };
    };

    home-manager = {
      enable = true;
    };
  };
}
