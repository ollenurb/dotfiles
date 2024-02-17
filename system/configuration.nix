# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, lib, ... }:

let
  customFonts = pkgs.nerdfonts.override {
    fonts = [ "Hack" ];
  };
in
{

  environment.variables.XCURSOR_SIZE = "32";

  imports = [
      ./hardware-configuration.nix
      ./services.nix
  ];

  # Enabling dconf allow the use of gsettings
  programs.dconf.enable = true;
  services = {
    dbus = {
      enable = true;
      packages = [ pkgs.dconf ];
    };
    # Xorg-configurations
    xserver = {
      enable = true;
      xkb.layout = "us";
      autorun = true;
      videoDrivers = ["nvidia"];
      screenSection = ''
        Option         "metamodes" "3440x1440_100 +0+0"
      '';

      # Display Manager configurations
      displayManager = {
        defaultSession = "none+i3";
        autoLogin.enable = true;
        autoLogin.user = "matteo";
        lightdm.greeter.enable = false;
      };

      # i3-configurations
      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
      };
    };
  };

  # Setup nvidia driver
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.nvidia.modesetting.enable = true;

  # Enable secret storing service
  services.gnome.gnome-keyring.enable = true;

  nixpkgs.config.allowUnfree = true;
  # Enable opengl
  hardware.opengl.enable = true;
  # Enable ADB
  programs.adb.enable = true;

  # Use the GRUB bootloader.
  boot.loader = {
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
    };
    efi.canTouchEfiVariables = true;
  };

  # Define your hostname
  networking.hostName = "pluto";

  # Setup network manager and nm-applet
  networking.networkmanager = {
    enable = true;
    wifi.scanRandMacAddress = false;
  };

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp4s0.useDHCP = false;
  networking.interfaces.wlp8s0.useDHCP = false;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";
  services.xserver.xkb.variant = "altgr-intl";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound = {
    enable = true;
  };
  hardware.pulseaudio.enable = true;

  # Making fonts accessible to applications.
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = ["Hack"]; })
  ];
  /* fonts.fonts = customFonts; */

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.matteo = {
    isNormalUser = true;
    extraGroups = ["wheel" "adbusers"]; # Enable ‘sudo’ and `adb` for the user.
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;

  # Nix daemon config
  nix = {
    package = pkgs.nixFlakes;

    # Automate `nix-store --optimise`
    optimise.automatic = true;

    # Automate garbage collection
    gc = {
      automatic = true;
      dates     = "weekly";
      options   = "--delete-older-than 7d";
    };

    # Avoid unwanted garbage collection when using nix-direnv
    extraOptions = ''
      keep-outputs     = true
      keep-derivations = true
      experimental-features = nix-command flakes
    '';

    # Required by Cachix to be used as non-root user
    # trusted-users = [ "root" "matteo" ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    rclone
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
  ];

  # List services that you want to enable:
  services.acpid.enable = true;

  # Enable this only when you need to use calibre
  services.udisks2.enable = true;

  # Enable Podman (an alternative docker engine)
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
    };
  };

  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}

