{ config, lib, pkgs, user, stateVersion, ... }:

let
  editor = "nvim";
in
{

  imports = [
    ./zsh.nix
    ../../theming/catppuccin.nix
  ];

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    stateVersion = stateVersion;
    sessionVariables = {
      EDITOR = "${editor}";
    };
  };

  # Change GTK theme
  gtk = {
    enable = true;
    font.name = "JetBrainsMono Nerd Font 10";

    theme = {
      package = pkgs.catppuccin-gtk.override {
        variant = "mocha";
        accents = ["peach"];
      };
      name = "Catppuccin-Mocha-Standard-Peach-Dark";
    };

    iconTheme = {
      package = pkgs.gruvbox-dark-icons-gtk;
      name = "oomox-gruvbox-dark";
    };
  };

  # Change cursor
  home.pointerCursor = {
    name = "Catppuccin-Mocha-Dark-Cursors";
    package = pkgs.catppuccin-cursors.mochaDark;
    size = 16;
  };

  programs = {
    # Direnv config
    direnv.enable = true;
    direnv.nix-direnv.enable = true;
    bat = {
        enable = true;
    };

    # Git config
    git = {
      enable = true;
      userName = "Ollenurb";
      userEmail = "brunello.mtt@gmail.com";
      extraConfig = {
        core.editor = "${editor}";
        init.defaultBranch = "main";
      };
    };
  };

}
