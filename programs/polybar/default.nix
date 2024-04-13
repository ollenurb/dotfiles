{ config, pkgs, lib, hasBattery, hdpi, host, ... }:

let
  myPolybar = pkgs.polybar.override {
    i3Support = true;
    alsaSupport = true;
    iwSupport = true;
    githubSupport = true;
    pulseSupport = true;
  };

  battScript = pkgs.callPackage ./batterycomb.nix {};

  battery = if hasBattery then "battery-combined" else "";

  white = "#FFFFFF";
in
{
  services.polybar = {
    enable = true;
    package = myPolybar;
    script = "polybar top &";
    settings = {
      "global/wm" = {
        margin-bottom = 0;
        margin-top = 0;
      };

      "bar/top" = {
        enable-ipc = true;
        width = "100%";
        height = 30;
        top = true;
        background = "#321E1E2E"; # transparent background
        foreground = white;
        font-0 = "JetBrainsMono Nerd Font:style=Mono:pixelsize=14:antialias=true;3";
        font-1 = "JetBrainsMono Nerd Font:style=Mono:pixelsize=18:antialias=true;3";
        font-2 = "JetBrainsMono Nerd Font:style=Bold:pixelsize=11:antialias=true;3";
        font-3 = "unifont:fontformat=truetype:size=8:antialias=false";
        modules-left = "lseparator i3 rseparator";
        modules-center = "lseparator date rseparator";
        modules-right = "lseparator cpu space filesystem space pulseaudio rseparator group-spacer lseparator ${battery} space network tray rseparator";
        override-redirect = false;
        cursor-click = "pointer";
        cursor-scroll = "ns-resize";
        line-size = 2;
        module-margin = "0px";
        padding-right = "1";
        padding-left = "1";
      };

      "module/tray" = {
        type = "internal/tray";
        format-padding = "8px";
        tray-spacing = "8px";
        format-background = "${config.colors.background}";
        tray-background = "${config.colors.background}";
      };

      "module/rseparator" = {
        type = "custom/text";
        content = "";
        content-font = 2;
        content-foreground = "${config.colors.background}";
      };

      "module/space" = {
        type = "custom/text";
        content = " ";
        content-font = 2;
        # content-foreground = "${config.colors.background}";
        content-background = "${config.colors.background}";
      };

      "module/group-spacer" = {
        type = "custom/text";
        content = " ";
        content-font = 2;
      };

      "module/lseparator" = {
        type = "custom/text";
        content = "";
        content-font = 2;
        content-foreground = "${config.colors.background}";
      };

      "module/i3" = {
        format-background = "${config.colors.background}";
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
        format-background = "${config.colors.background}";
        type = "internal/date";
        format = "<label>";
        interval = 5;
        date-alt = "%A %d %b";
        time = "%H:%M";
        label = "%date%%time%";
        label-padding = 1;
      };

      "module/pulseaudio" = {
        format-volume-background = "${config.colors.background}";
        type = "internal/pulseaudio";
        format-volume = "<ramp-volume> <label-volume>";
        label-volume = "%percentage%%";
        label-muted = "󰖁 Muted";
        ramp-volume = ["󰕿" "󰖀" "󰕾"];
        click-right = "${pkgs.pavucontrol}/bin/pavucontrol";
      };

      "module/filesystem" = {
        format-mounted-background = "${config.colors.background}";
        type = "internal/fs";
        mount-0 = "/";
        fixed-values = false;
        format-mounted = "  <label-mounted>";
        label-mounted = "%used%";
      };

      "module/cpu" = {
        format-background = "${config.colors.background}";
        type = "internal/cpu";
        format = "  <label>";
        label = "%percentage%%";
      };

      "module/network" = {
        format-connected-background = "${config.colors.background}";
        format-disconnected-background = "${config.colors.background}";
        type = "internal/network";
        interface = if host == "lambda" then "wlan0" else "wlp8s0";
        interval = "5";
        label-connected = "%{A1:alacritty -e nmtui:}%essid%%{A}";
        format-disconnected = "󰖪  Disconnected";
        format-connected = "  <label-connected>"; 
      };
      
      "module/battery-combined" = lib.mkIf hasBattery {
        format-background = "${config.colors.background}";
        type = "custom/script";
        exec = "${battScript}/bin/batterycomb";
        format = "<label>";
        label = "%output%";
        interval = 5;
      };

    };
  };
}
