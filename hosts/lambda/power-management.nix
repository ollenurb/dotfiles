{ config, lib, pkgs, ... }:

{
  # Enable battery management through powertop
  powerManagement.powertop.enable = true;

  boot = {
    initrd.kernelModules = [ "thinkpad-acpi" ];
    kernelParams = [
      "msr.allow_writes=on"
      "cpuidle.governor=teo"
    ];
  };

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      DEVICES_TO_DISABLE_ON_BAT = "bluetooth";

      NMI_WATCHDOG = 0;
      USB_BLACKLIST_PHONE = 1; /* Allow phone charging */
    };
  };

  systemd.services."thinkpad-sdcard" = {
    wantedBy = [ "multi-user.target" ];
    description = "Disable Thinkpad SD-card";
    script = ''
      echo 2-3 >> /sys/bus/usb/drivers/usb/bind || true
      echo 2-3 >> /sys/bus/usb/drivers/usb/unbind
    '';
  };

}
