{ lib, ... }:

{
  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;
    shadow = true;
    shadowOpacity = 0.6;
    shadowOffsets = [ 0 (-2) ];
    fade = true;
    fadeSteps = [ 0.04 0.04 ];
  };
}
