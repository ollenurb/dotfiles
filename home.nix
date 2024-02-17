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
    # obsidian                          # Digital brain
    anki-bin                          # Flashcards
    jetbrains.idea-ultimate           # IntelliJ
    zathura                           # .pdf viewer
    vifm                              # File manager
    # element-desktop                   # Matrix.org client
    calibre                           # Ebook Library
    neovide                           # Neovim GUI
    vscodium                          # VSCode
    unzip                             # unzip
    blender
    zotero
    musescore
  ];

  utilities = with pkgs; [
    pandoc                            # Documents generator
    entr                              # utility that watch for file changes
    ripgrep                           # faster grep
    htop                              # better top
    killall                           # kill all processes
    bat                               # cat with syntax hightlight
    duf                               # disk usage/free utility
    fd                                # "find" for files
    fzf                               # fuzzy finder
    eza                               # a better ls
    libnotify                         # notify-send command
    texlive.combined.scheme-full      # LaTeX
    jdk17                             # Java JDK
    unzip                             # Unzip stuff
    flameshot                         # Screenshots
    gcc                               # C/C++ Compiler
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

  juliaToolchain = with pkgs; [
    julia
  ];

in {
  imports = (import ./programs) ++ (import ./shell) ++ [(import ./theming/catppuccin.nix)];

  home = {
    username = "matteo";
    homeDirectory = "/home/matteo";
    stateVersion = "22.11";
    packages = programs ++ utilities ++ juliaToolchain /* ++ haskellToolchain */ ++ rustToolchain;
    sessionVariables = {
      EDITOR = "nvim";
      # Rust-related stuff
      RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
      PKG_CONFIG_PATH ="${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
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
    direnv.enable = true;
    direnv.nix-direnv.enable = true;
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
