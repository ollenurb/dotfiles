{ config, pkgs, lib, hdpi, ... }:

let
  # Get modifier key
  modifier = config.xsession.windowManager.i3.config.modifier;

  # Define a quoting funcion
  execCommand = { cmd, params ? ""}: "exec --no-startup-id \"${cmd} ${params}\"";

  # Define default programs
  browser = "${pkgs.firefox}/bin/firefox";
  programLauncher = "${pkgs.rofi}/bin/rofi";
  volumeControl = "${pkgs.pavucontrol}/bin/pavucontrol";
  terminal = "${pkgs.alacritty}/bin/alacritty";
  feh = "${pkgs.feh}/bin/feh";
in
{
  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };
  };

  # This will define the actual i3 configuration file
  xsession.windowManager.i3.config = {
    modifier = "Mod4";
    floating.modifier = modifier;
    bars = [];
    fonts = {
      names = ["JetBrainsMono Nerd Font"];
      size = 13.0;
    };

    defaultWorkspace = "workspace number 1";

    # Enable floating window for specific programs
    window.commands = [
        { command = "floating enable"; criteria = { instance = "pavucontrol"; }; }
        { command = "border pixel 1"; criteria = { instance = "^.*"; }; }
    ];

    # Restart polybar service on startup
    startup = [
      { command = "systemctl --user restart polybar"; always = true; notification = false; }
      { command = "$HOME/.fehbg"; always = false; notification = false; }
    ];

    gaps.inner = if hdpi then 12 else 0;
    gaps.smartBorders = "on";

    keybindings = lib.mkOptionDefault {
      # Power Menu and program Launcher
      "${modifier}+Shift+0" = execCommand {
        cmd = programLauncher;
        params = "-show power-menu -modi power-menu:rofi-power-menu";
      };

      "${modifier}+d" = execCommand {
        cmd = programLauncher;
        params = "-modi drun,run,ssh,window -show";
      };

      # Other programs
      "${modifier}+Shift+f" = execCommand { cmd = browser; };
      "${modifier}+Return" = execCommand { cmd = terminal; };
      "${modifier}+Ctrl+m" = execCommand { cmd = volumeControl; params = "&"; };

      # Change focus using vim-like bindings
      "${modifier}+j" = "focus down";
      "${modifier}+k" = "focus up";
      "${modifier}+l" = "focus right";
      "${modifier}+h" = "focus left";

      # Move windows using vim-like bindings
      "${modifier}+Shift+j" = "move down";
      "${modifier}+Shift+k" = "move up";
      "${modifier}+Shift+l" = "move right";
      "${modifier}+Shift+h" = "move left";

      # split in horizontal/vertical orientation
      "${modifier}+v" = "split h";
      "${modifier}+c" = "split v";

      # Cycle between workspaces
      "${modifier}+Ctrl+Right" = "workspace next";
      "${modifier}+Ctrl+Left" = "workspace prev";
      "${modifier}+Ctrl+l" = "workspace next";
      "${modifier}+Ctrl+h" = "workspace prev";
    };

    # Set Colors according to theming
    colors = with config.colors; {
      background = background;
      focused = {
        border = color7;
        background = background;
        text = foreground;
        childBorder = color7;
        indicator = foreground;
      };

      focusedInactive = {
        border = background;
        background = background;
        text = foreground;
        childBorder = background;
        indicator = background;
      };

      unfocused = {
        border = background;
        background = background;
        text = foreground;
        childBorder = background;
        indicator = background;
      };

    };

  };

}
