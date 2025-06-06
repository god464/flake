{ config, lib, ... }:
let
  backup-cfg = config.backup'.restic-backup;
  server-cfg = config.backup'.restic-server;
  inherit (lib) mkEnableOption mkIf mkMerge;
in
{
  options.backup' = {
    restic-backup.enable = mkEnableOption "restic-backup";
    restic-server.enable = mkEnableOption "restic-server";
  };
  config = mkMerge [
    mkIf
    backup-cfg.enable
    {
      services.restic.backups = {
        # TODO
      };
    }
    mkIf
    server-cfg.enable
    {
      services.restic.server = {
        enable = true;
        listenAddress = "0.0.0.0:8000";
      };
      networking.firewall = {
        allowedTCPPorts = [ 8000 ];
        allowedUDPPorts = [ 8000 ];
      };
    }
  ];
}
