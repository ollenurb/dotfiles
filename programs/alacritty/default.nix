{ config, pkgs, hdpi, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        padding.x = 0;
        padding.y = 0;
      };

      font = {
        normal.family = "JetBrainsMono Nerd Font Mono";
        size = if hdpi then 14.0 else 11.0;
      };

      shell = { program = "${pkgs.zsh}/bin/zsh"; };
      
      selection.save_to_clipboard = true;

      colors = {
        primary = {
          background = "${config.colors.background}";
          foreground = "${config.colors.foreground}";
        };
        # Normal colors
        normal = {
          black =  "${config.colors.color0}";
          red =    "${config.colors.color1}";
          green =  "${config.colors.color2}";
          yellow = "${config.colors.color3}";
          blue =   "${config.colors.color4}";
          magenta ="${config.colors.color5}";
          cyan =   "${config.colors.color6}";
          white =  "${config.colors.color7}";
        };

        # Bright colors
        bright = {
          black =  "${config.colors.color8}";
          red =    "${config.colors.color9}";
          green =  "${config.colors.color10}";
          yellow = "${config.colors.color11}";
          blue =   "${config.colors.color12}";
          magenta ="${config.colors.color13}";
          cyan =   "${config.colors.color14}";
          white =  "${config.colors.color15}";
        };
      };
    };
  };
}
