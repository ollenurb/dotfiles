{ lib, ... }:

{
  services.picom = {
    enable = true;
    vSync = true;
    shadow = true;
    shadowOpacity = "0.6";
    shadowOffsets = [ 0  (-2) ];
    fade = true;
    fadeDelta = 5;
    fadeSteps = [ "0.03"  "0.03" ];
    extraOptions = ''
    xrender-sync-fence = true;
    blur-strength = 6;
    '';
    blur = true;
    opacityRule = [
      "90:class_g = 'URxvt'"
      "90:name = 'Alacritty' && focused"
      "90:class_g = 'Alacritty' && !focused"
    ];
  };
}
