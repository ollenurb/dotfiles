{ lib, ... }:

{
  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;
    shadow = true;
    shadowOpacity = 0.6;
    shadowOffsets = [ 0  (-2) ];
    fade = true;
    fadeSteps = [ 0.04  0.04 ];
    /* settings = { */
    /*     blur = { */
    /*         method = "dual_kawase"; */
    /*         size = 10; */
    /*         deviation = 5.0; */
    /*         strenght = 8; */
    /*     }; */
    /* }; */
    /* opacityRules = [ */
    /*   "85:class_g = 'URxvt'" */
    /*   "85:name = 'Neovide'" */
    /*   "85:name = 'Alacritty' && focused" */
    /*   "85:class_g = 'Alacritty' && !focused" */
    /*   /1* "40:class_g = 'Polybar'" *1/ */
    /* ]; */
  };
}
