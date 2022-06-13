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
    '';
    blur = true;
    opacityRule = [
      "85:class_g = 'URxvt'"
      "85:name = 'Alacritty' && focused"
      "85:class_g = 'Alacritty' && !focused"
      "85:class_g = 'Polybar'"
    ];
  };
}
