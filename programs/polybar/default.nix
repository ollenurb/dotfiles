{ config, pkgs, lib ,... }:

let
  myPolybar = pkgs.polybar.override {
    i3GapsSupport = true;
    alsaSupport = true;
    iwSupport = true;
    githubSupport = true;
    pulseSupport = true;
  };
  alphaBg = "#B4" + lib.removePrefix "#" config.colors.background;
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
        /* I've put some transparency by appending its HEX alpha value */
        background = "${alphaBg}";
        foreground = "${config.colors.foreground}";
        font-0 = "Hack Nerd Font:style=Mono:pixelsize=14:antialias=true;3";
        font-1 = "Hack Nerd Font:style=Mono:pixelsize=24:antialias=true;3";
        font-2 = "Hack Nerd Font:style=Bold:pixelsize=11:antialias=true;3";
        font-3 = unifont:fontformat=truetype:size=8:antialias=false;
        modules-left = "separator i3";
        modules-center = "date";
        modules-right = "cpu separator filesystem separator pulseaudio separator";
        tray-position = "right";
        override-redirect = false;
        cursor-click = "pointer";
        cursor-scroll = "ns-resize";
        line-size = 2;
      };

      "module/separator" = {
        type = "custom/text";
        content = " ";
      };

      "module/i3" = {
        type = "internal/i3";
        format = "<label-state> <label-mode>";
        index-sort = true;
        wrapping-scroll = false;
        pin-workspaces = false;
        strip-wsnumbers = true;
        label.mode-padding = 1;

        # focused = Active workspace on focused monitor
        label-focused = "%index%";
        label-focused-padding = 1;
        label-focused-underline = "${config.colors.foreground}";

        # unfocused = Inactive workspace on any monitor
        label-unfocused = "%index%";
        label-unfocused-padding = 1;

        # visible = Active workspace on unfocused monitor
        label-visible = "%index%";
        label-visible-padding = 1;

        # urgent = Workspace with urgency hint set
        label-urgent = "%index% ";
        label-urgent-foreground = "${config.colors.color9}";
        label-urgent-padding = 1;
      };

      "module/date" = {
        type = "internal/date";
        format = "<label>";
        interval = 5;
        date-alt = "%A %d %b";
        time = "%H:%M";
        label = "%date%%time%";
        label-padding = 1;
      };

      "module/pulseaudio" = {
        type = "internal/pulseaudio";
        format-volume = "<ramp-volume> <label-volume>";
        format-volume-padding = 1;
        # format-volume-foreground = "${config.colors.color0}";
        # format-volume-background = "${config.colors.color12}";
        label-volume = "%percentage%%";
        label-muted = "婢 Muted";
        # label-muted-background = "${colors.Cyan}";
        ramp.volume = ["奄" "奔" "墳"];
        click-right = "${pkgs.pavucontrol}/bin/pavucontrol";
      };

      "module/filesystem" = {
        type = "internal/fs";
        mount-0 = "/";
        fixed-values = false;
        format-mounted = " <label-mounted>";
        label-mounted = "%used%/%total%";
      };

      "module/cpu" = {
        type = "internal/cpu";
        format = " <label>";
        label = "%percentage%%";
        format-padding = 1;
      };

    };
  };
}
