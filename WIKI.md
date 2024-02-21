# Wiki

Here are some useful informations regarding general maintainability and usage
of the system.

## Drive sync

There is a systemd service (`drive_mount`) that synchronizes the content of
Google Drive with the `~/Remote` folder. Make sure you have configured the
remote named `drive` using `rclone` if the service doesn't start.
[Here](https://rclone.org/drive/) is a quick guide to set it up.

## Update system

### Channel-based update
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

### Flake-based update (recommended)

1. `nix flake update` (update the `flake.lock` dependencies)
2. Build the system using one of the following commands:
    * `apply-system`
    * `sudo nixos-rebuild switch --flake .#HOSTNAME` (*required to build the
      system the first time*)
