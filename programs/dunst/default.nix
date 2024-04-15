{ config, pkgs, ... }:

{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 300;
        height = 150;
        origin = "top-right";
        offset = "0x23";
        frame_width = 0;
        font = "JetBrainsMono Nerd Font 12";
        word_wrap = true;
        markup = true;
        format = "<b>%s</b>\\n\\n%b";
        alignment = "left";
        shrink = false;
        padding = 8;
        horizontal_padding = 10;
        max_icon_size = 80;
      };

      urgency_low = {
        background = "${config.colors.background}";
        foreground = "${config.colors.foreground}";
        timeout = 3;
      };

      urgency_normal = {
        background = "${config.colors.background}";
        foreground = "${config.colors.foreground}";
        timeout = 10;
      };

      urgency_critical = {
        background = "${config.colors.color1}";
        foreground = "${config.colors.background}";
        timeout = 10;
      };
    };
  };
}
