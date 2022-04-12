{ pkgs, config, ... }:

let
  rofiTheme = import ./theme.nix {config = config;};
in
{
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = rofiTheme;
    font = "Hack Nerd Font 12";
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
