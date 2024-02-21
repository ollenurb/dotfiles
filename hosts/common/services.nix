{ pkgs, lib, config, security, ... }:

let
    mountDir = "/home/matteo/Remote";
    remoteDir = "drive";
in
{
    # Allow fusemount
    environment.etc."fuse.conf".text = ''
      user_allow_other
    '';

    security.wrappers = {
      fusermount.source = "${pkgs.fuse}/bin/fusermount";
    };


    systemd.user.services.drive_mount = {
        unitConfig = {
            Description = "Mount Google Drive";
            After = [ "network-online.target" ];
        };
        wantedBy = [ "multi-user.target" ];

        serviceConfig = {
            ExecStartPre = "/run/current-system/sw/bin/mkdir -p ${mountDir}";
            ExecStart = ''
                ${pkgs.rclone}/bin/rclone mount ${remoteDir}: ${mountDir} \
                    --dir-cache-time 48h \
                    --vfs-cache-mode full \
                    --vfs-cache-max-age 48h \
                    --vfs-read-chunk-size 10M \
                    --vfs-read-chunk-size-limit 512M \
                    --buffer-size 512M
            '';
            ExecStop = "/run/wrappers/bin/fusermount -u ${mountDir}";
            Type = "notify";
            Restart = "always";
            RestartSec = "10s";
            Environment = [ "PATH=/run/wrappers/bin/:$PATH" ];
        };
    };
}
