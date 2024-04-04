{ config, pkgs, lib, hdpi, ... }:

{
    wayland.windowManager.hyprland.enable = true;
    wayland.windowManager.hyprland.xwayland.enable = true;
    wayland.windowManager.hyprland.settings = {
        "$mod" = "SUPER";
        bind = [
            "$mod, F, exec, firefox"
            "$mod, D, exec, wofi"
            "$mod, enter, exec, alacritty"
        ];
    };
}
