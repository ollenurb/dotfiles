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
        background = "${config.colors.background}";
        foreground = white;
        font-0 = "JetBrainsMono Nerd Font:style=Mono:pixelsize=14:antialias=true;3";
        font-1 = "JetBrainsMono Nerd Font:style=Mono:pixelsize=18:antialias=true;3";
        font-2 = "JetBrainsMono Nerd Font:style=Bold:pixelsize=11:antialias=true;3";
        font-3 = "unifont:fontformat=truetype:size=8:antialias=false";
        modules-left = "i3";
        modules-center = "date";
        modules-right = "cpu filesystem pulseaudio ${battery} network";
        tray-position = "right";
        tray-foreground = "${config.colors.foreground}";
        tray-padding = "2px";
        override-redirect = false;
        cursor-click = "pointer";
        cursor-scroll = "ns-resize";
        line-size = 2;
        module-margin = "8px";
        padding-right = "1";
      };

      "module/rseparator" = {
        type = "custom/text";
        content = "";
        content-font = 2;
        content-foreground = "${config.colors.foreground}";
      };

      "module/lseparator" = {
        type = "custom/text";
        content = "";
        content-font = 2;
        content-foreground = "${config.colors.foreground}";
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
        label-volume = "%percentage%%";
        label-muted = "󰖁 Muted";
        ramp-volume = ["󰕿" "󰖀" "󰕾"];
        click-right = "${pkgs.pavucontrol}/bin/pavucontrol";
      };

      "module/filesystem" = {
        type = "internal/fs";
        mount-0 = "/";
        fixed-values = false;
        format-mounted = " <label-mounted>";
        label-mounted = "%used%";
      };

      "module/cpu" = {
        type = "internal/cpu";
        format = " <label>";
        label = "%percentage%%";
      };

      "module/network" = {
        type = "internal/network";
        interface = if host == "lambda" then "wlan0" else "wlp8s0";
        interval = "5";
        label-connected = "%{A1:alacritty -e nmtui:}%essid%%{A}";
        format-disconnected = "󰖪 Disconnected";
        format-connected = " <label-connected>"; 
      };
      
      "module/battery-combined" = lib.mkIf hasBattery {
        type = "custom/script";
        exec = "${battScript}/bin/batterycomb";
        format = "<label>";
        label = "%output%";
        interval = 5;
      };

    };
  };
}
