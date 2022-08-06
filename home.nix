{ config, lib, pkgs, stdenv, ... }:

let
  programs = with pkgs; [
    nix-doc                           # nix documentation search tool
    pavucontrol                       # pulseaudio control
    firefox                           # browser
    spotify                           # Music player
    feh                               # Image viewer
    tdesktop                          # Telegram
    mpv                               # Video Player
    rofi-power-menu                   # Power menu
    obsidian                          # Digital brain
    anki-bin                          # Flashcards
    jetbrains.idea-ultimate           # IntelliJ
    zathura                           # .pdf viewer
    element-desktop                   # Matrix.org client
    calibre                           # Ebook Library
    neovide                           # Neovim GUI
  ];

  utilities = with pkgs; [
    pandoc                            # Documents generator
    entr                              # utility that watch for file changes
    ripgrep                           # faster grep
    htop                              # better top
    killall                           # kill all processes
    duf                               # disk usage/free utility
    fd                                # "find" for files
    fzf                               # fuzzy finder
    exa                               # a better ls
    libnotify                         # notify-send command
    gnumake                           # Make utility
    texlive.combined.scheme-full      # LaTeX
  ];

  haskellPkgs = with pkgs.haskellPackages; [
    brittany                          # code formatter
    cabal-install                     # cabal
    ghc                               # compiler
    cabal2nix                         # converts .cabal > .nix
  ];

in {
  imports = (import ./programs) ++ (import ./shell) ++ [(import ./theming/onedark.nix)];

  home = {
    username = "matteo";
    homeDirectory = "/home/matteo";
    packages = programs ++ utilities ++ haskellPkgs;
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

  programs = {
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
