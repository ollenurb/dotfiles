# Personal Wiki

Here are some useful informations regarding general maintainability and usage
of the system.

## Drive Sync

There is a systemd service (`drive_mount`) that synchronizes the content of
Google Drive with the `~/Remote` folder. Make sure you habe configured the
remote named `drive` using `rclone` if the service doesn't start.
[Here](https://rclone.org/drive/) is a quick guide to set it up.

## Update System

### Channel-Based Update
Update the system to a major channel release:

1. `sudo nix-channel --remove nixos`
2. `sudo nix-channel --add <NEW_CHANNEL_URL> nixos`
3. `sudo nix-channel --update`
4. `apply-system`

Update home-manager to a major channel release:

1. `nix-channel --remove home-manager`
2. `nix-channel --add <NEW_HOME_MANAGER_CHANNEL_URL> home-manager`
3. `nix-channel --update`
4. `apply-home`

Update the system/home to a channel update:

1. `sudo nix-channel --update` (for home-manager `nix-channel --update`)
2. `apply-system` (for home-manager `apply-home`)

### Flake-Based Update

Update the `flake.lock` dependencies

1. `nix flake update`
2. `apply-system` or/and `apply-home`

## Stream the iPad screen
To mirror the iPad screen, you need to use the UxPlay server:

1. Add this configuration to your system `configuration.nix` file

```nix
# Enable the Avahi daemon (Essentially used to stream the iPad screen)
services.avahi = {
  enable = true;
  nssmdns = true;
  publish = {
    enable = true;
    addresses = true;
    workstation = true;
    userServices = true;
  };
};

# Open the required ports in the firewall.
networking.firewall.allowedTCPPorts = [ 7000 7100 ];
networking.firewall.allowedUDPPorts = [ 6000 6001 7011 ];
```

2. Install (or `nix-shell` into) `uxserver`, then run it

## Pandoc
**Setting up**:
1. Install `pandoc` using `home.nix`
2. Replace the cloned `.pandoc` folder with the `dotfiles/programs/pandoc/` folder
3. To compile using the *"dispense"* configuration, run `pandoc INPUT_FILES -d
   dispense.yaml -o OUTFILE`


