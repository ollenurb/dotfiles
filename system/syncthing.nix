{ config, pkgs, lib, ... }:

{
  services.syncthing = {
    user = "matteo";
    group = "wheel";
    enable = true;
    dataDir = "/home/matteo/Storage/Syncthing";
    configDir = "/home/matteo/Storage/Syncthing/.config/syncthing";
    overrideDevices = true;
    overrideFolders = true;
    openDefaultPorts = true;
    devices = {
        "iPad" = { id = "<YOUR DEVICE ID>"; };
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
  };
}

