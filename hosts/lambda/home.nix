{ config, lib, pkgs, user, ... }:

let
  programs = with pkgs; [
    btop				                      # better top
    killall                 		      # kill all processes
    duf                     		      # disk usage/free utility
    fd                      		      # "find" for files
    fzf                               # fuzzy finder
    eza                      		      # a better ls
    nix-doc                 		      # nix documentation search tool
    pavucontrol             		      # pulseaudio control
    firefox                 		      # browser
    pandoc                            # Documents generator
    texlive.combined.scheme-full      # LaTeX
    spotify                           # Music player
    rofi-power-menu                   # Power menu
    feh                               # Image viewer
    flameshot                         # Screeshot taker
    tdesktop                          # Telegram
    #obsidian                          # Knowledge Management System
    zotero                            # Bibliography
    gnumake                           # Make utility
    anki-bin                          # Spaced-repetition program
    mpv                               # Video Player
    zathura                           # .pdf viewer
    ripgrep                           # faster grep
    ripgrep-all                       # Grep also inside pdfs, ebooks, etc.
    entr                              # utility that watch for file changes
    vscodium                          # VS Code Editor
    calibre                           # Ebook Reader
    slack
    gnome.nautilus
    rclone
  ];

  rustToolchain = with pkgs; [
    cargo                             # cargo
    rustc                             # compiler
    rustfmt                           # formatter
  ];
in
{
  imports = [
    ../common/home.nix
    ../../programs/alacritty
    ../../programs/dunst
    ../../programs/i3
    ../../programs/neovim
    ../../programs/polybar
    ../../programs/rofi
    ../../programs/redshift
  ];

  home.packages = programs ++ rustToolchain;

}


