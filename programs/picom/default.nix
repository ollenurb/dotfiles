{ lib, ... }:

{
  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;
    # shadow = true;
    # shadowExclude = ["window_type = 'dock'"];
    # shadowOpacity = 0.6;
    # shadowOffsets = [ 0 (-2) ];
    fade = true;
    fadeSteps = [ 0.04 0.04 ];

    opacityRules = [
      "90:class_g = 'URxvt'"
      "80:name = 'Alacritty'"
    ];

    settings = {
        blur = {
            method = "gaussian";
            size = 10;
            deviation = 5.0;
            strenght = 20;
        };
    };

  };
}
