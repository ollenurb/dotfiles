{ config, pkgs, ... }:

{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        geometry = "500x6-24+44";
        frame_width = 0;
        font = "Iosevka Nerd Font 12";
        word_wrap = true;
        markup = true;
        format = "<b>%s</b>\n%b";
        alignment = "left";
        shrink = false;
        padding = 8;
        horizontal_padding = 10;
        max_icon_size = 80;
      };

      urgency_low = {
        background = "${config.colors.color12}";
        foreground = "${config.colors.background}";
      	timeout = 10;
      };

      urgency_normal = {
        background = "${config.colors.color12}";
        foreground = "${config.colors.background}";
        timeout = 10;
      };

      urgency_critical = {
        background = "${config.colors.color1}";
        foreground = "${config.colors.background}";
        timeout = 0;
      };
    };
  };
}
