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
      layout = "us";
      /* autorun = true; */
      videoDrivers = ["nvidia"];
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

  # Enable secret storing service
  services.gnome.gnome-keyring.enable = true;

  nixpkgs.config.allowUnfree = true;
  # Enable opengl
  /* hardware.opengl.enable = true; */
  # Enable ADB
  programs.adb.enable = true;

  # Use the GRUB bootloader.
  boot.loader = {
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      # splashImage = ../theming/grub_bg.png;
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

  programs.nm-applet.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp4s0.useDHCP = false;
  networking.interfaces.wlp8s0.useDHCP = false;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "us";
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound = {
    enable = true;
  };
  hardware.pulseaudio.enable = true;

  # Making fonts accessible to applications.
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = ["Hack"]; })
  ];

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.matteo = {
    isNormalUser = true;
    extraGroups = ["wheel" "adbusers" "libvirtd"]; # Enable ‘sudo’ and `adb` for the user.
    shell = pkgs.zsh;
  };

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
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
  ];

  # List services that you want to enable:
  services.acpid.enable = true;

  # Enable the OpenSSH daemon.
  /* # services.openssh.enable = true; */

  # Enable nested virtualization
  /* boot.extraModprobeConfig = "options kvm_amd nested=1"; */

  # Enable Podman (an alternative docker engine)
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
    };
  };

  # Enable the Avahi daemon (Essentially used to stream the iPad screen)
  # services.avahi = {
  #   enable = true;
  #   nssmdns = true;
  #   publish = {
  #     enable = true;
  #     addresses = true;
  #     workstation = true;
  #     userServices = true;
  #   };
  # };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 7000 7100 ];
  # networking.firewall.allowedUDPPorts = [ 6000 6001 7011 ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}

