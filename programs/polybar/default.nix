{ config, pkgs, ... }:

let
  myPolybar = pkgs.polybar.override {
    i3GapsSupport = true;
    alsaSupport = true;
    iwSupport = true;
    githubSupport = true;
    pulseSupport = true;
  };
in
{
  services.polybar = {
    enable = true;
    package = myPolybar;
    # config = ./config.ini;
    script = "polybar top &";
    settings = {
      "global/wm" = {
        margin-bottom = 0;
        margin-top = 0;
      };

      "bar/top" = {
        width = "100%";
        height = 30;
        top = true;
        background = "${config.colors.background}";
        foreground = "${config.colors.foreground}";
        padding = 0;
        font-0 = "Hack Nerd Font:style=Mono:pixelsize=14:antialias=true;3";
        font-1 = "Hack Nerd Font:style=Mono:pixelsize=24:antialias=true;3";
        font-2 = "Hack Nerd Font:style=Bold:pixelsize=11:antialias=true;3";
        font-3 = unifont:fontformat=truetype:size=8:antialias=false;
        modules-left = "i3";
        modules-center = "date";
        modules-right = "pulseaudio memory ";
        tray-position = "right";
        tray-padding = 1;
        override-redirect = false;
        cursor-click = "pointer";
        cursor-scroll = "ns-resize";
      };

      "module/i3" = {
        type = "internal/i3";
        format = "<label-state> <label-mode>";
        index-sort = true;
        wrapping-scroll = false;
        pin-workspaces = false;
        strip-wsnumbers = true;
        ws-icon-0 = "1;";
        ws-icon-1 = "2;";
        ws-icon-2 = "3;";
        ws-icon-3 = "4;";
        ws-icon-4 = "5;";
        ws-icon-5 = "6;";
        ws-icon-6 = "7;";
        ws-icon-7 = "8;";
        ws-icon-8 = "9;";
        ws-icon-9 = "10;";

        label.mode-padding = 1;
        label-mode-foreground = "${config.colors.color0}";
        label-mode-background = "${config.colors.color12}";

        # focused = Active workspace on focused monitor
        label-focused = "%index% %icon%";
        label-focused-padding = 1;
        # label-focused-foreground = ${self.label-mode-foreground}

        # unfocused = Inactive workspace on any monitor
        label-unfocused = "%index%";
        label-unfocused-padding = 1;
        # label-unfocused-foreground = ${self.label-mode-foreground}

        # visible = Active workspace on unfocused monitor
        label-visible = "%index%";
        label-visible-padding = 1;

        # urgent = Workspace with urgency hint set
        label-urgent = "%index% ";
        label-urgent-foreground = "${config.colors.color9}";
        label-urgent-padding = 1;

        label-separator = "|";
        label-separator-foreground = "${config.colors.color0}";
      };

      "module/date" = {
        type = "internal/date";
        interval = 5;
        date-alt = "%A %d %b";
        time = "%H:%M";
        label = "%date% %time% ";
        label-padding = 1;
        label-background = "${config.colors.color12}";
      };

      "module/pulseaudio" = {
        type = "internal/pulseaudio";
        format-volume = "<ramp-volume> <label-volume>";
        # format-volume-foreground = "${config.colors.color0}";
        # format-volume-background = "${config.colors.color12}";
        label-volume = "%percentage%%";
        label-muted = "婢 Muted";
        # label-muted-background = "${colors.Cyan}";
        ramp.volume = ["奄" "奔" "墳"];
        click-right = "${pkgs.pavucontrol}/bin/pavucontrol";
      };
    };
  };
}
