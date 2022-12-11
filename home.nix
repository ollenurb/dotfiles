{ config, lib, pkgs, stdenv, ... }:

let
  programs = with pkgs; [
    nix-doc                           # nix documentation search tool
    pavucontrol                       # pulseaudio control
    firefox                           # browser
    feh                               # Image viewer
    tdesktop                          # Telegram
    mpv                               # Video Player
    rofi-power-menu                   # Power menu
    obsidian                          # Digital brain
    anki-bin                          # Flashcards
    jetbrains.idea-ultimate           # IntelliJ
    zathura                           # .pdf viewer
    vifm                              # FIle manager
    element-desktop                   # Matrix.org client
    calibre                           # Ebook Library
    neovide                           # Neovim GUI
    vscodium                          # VSCode
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
    jdk11                             # Java JDK
  ];

  rustToolchain = with pkgs; [
    cargo                             # cargo
    rustc                             # compiler
    rustfmt                           # formatter
  ];

  haskellToolchain = with pkgs.haskellPackages; [
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
    stateVersion = "22.11";
    packages = programs ++ utilities ++ haskellToolchain ++ rustToolchain;
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
