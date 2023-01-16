{ config, pkgs, lib, ... }:

{
  services.syncthing = {
    enable = true;
    dataDir = "/home/matteo/Storage/Syncthing";
    configDir = "/home/matteo/Storage/Syncthing/.config";
    overrideDevices = true;
    overrideFolders = true;
    devices = {
        "iPad" = { id = "X7GU3DG-4WCJWLA-XBGCR2J-YTOPNXO-OSJUZXP-7ZVUVI2-PW44CQX-FEBW7AQ"; };
    };
    folders = {
        "Books" = {
            path = "/home/matteo/Storage/Books";
            devices = [ "iPad" ];
        };
        "University" = {
            path = "/home/matteo/Storage/University";
            devices = [ "iPad" ];
        };
    };
  }
}

