# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, lib, host, user, stateVersion, ... }:

let
  customFonts = pkgs.nerdfonts.override {
    fonts = [ "JetBrainsMono" ];
  };
in
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware.nix
      # Power management
      ./power-management.nix
      # Custom Services
      ../common/services.nix 
    ];

  boot.initrd.availableKernelModules = [
    "thinkpad_acpi"
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
      videoDrivers = [ "intel" ];
      autorun = true;
      # Display Manager configurations
      displayManager = {
        defaultSession = "none+i3";
        autoLogin.enable = true;
        autoLogin.user = "${user}";
        lightdm.greeter.enable = false;
      };
      # i3-configurations
      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
      };
    };
  };

  # Allow fusemount
  environment.etc."fuse.conf".text = ''
    user_allow_other
  '';

  security.wrappers = {
    fusermount.source = "${pkgs.fuse}/bin/fusermount";
  };

  # Load VAAPI drivers to offload video decoding/encoding from the CPU
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver    # iHD
      vaapiIntel            # i965
      rclone
    ];
  };

  # Use the GRUB bootloader.
  boot.loader = {
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      splashImage = ../../theming/grub_bg.png;
    };
    efi.canTouchEfiVariables = true;
  };

  # Define your hostname
  networking.hostName = "${host}";

  # Setup network manager and nm-applet
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = false;
  # networking.interfaces.wlp4s0.useDHCP = false;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "us";
  };
  # set layout
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.variant = "altgr-intl";
  # disable xterm
  services.xserver = {
    excludePackages = [ pkgs.xterm ];
    desktopManager.xterm.enable = false;
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable BT
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  hardware.trackpoint = {
    enable = true;
    emulateWheel = true;
    speed = 250;
    sensitivity = 100;
  };

  # Enable sound.
  sound = {
    enable = true;
  };

  hardware.pulseaudio.enable = true;

  # Making fonts accessible to applications.
  fonts.packages = with pkgs; [
    customFonts
    font-awesome
  ];

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${user}" = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  # Nix daemon config
  nix = {
    package = pkgs.nixFlakes;
    # Automate `nix-store --optimise`
    settings.auto-optimise-store = true;

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
    settings.trusted-users = [ "root" "${user}" ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim 
    wget
    xorg.xbacklight
    # just to check if we have VA-API enabled
    libva-utils
  ];

  # List services that you want to enable:
  services.acpid.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  services.blueman.enable = true;

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
  system.stateVersion = stateVersion; # Did you read the comment?

}
