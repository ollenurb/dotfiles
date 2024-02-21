{ pkgs, config, hdpi, ... }:

let
  rofiTheme = import ./theme.nix { config = config; hdpi = hdpi; };
in
{
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = rofiTheme;
    font = "JetBrainsMono Nerd Font 12";
    extraConfig = {
      show-icons = true;
    	icon-theme = "Papirus";
      display-drun = "";
      drun-display-format = "{name}";
      disable-historyf = false;
	    sidebar-mode = false;
    };
  };
}
