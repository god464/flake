{ config, lib, ... }:
let
  backup-cfg = config.backup'.restic-backup;
  server-cfg = config.backup'.restic-server;
  inherit (lib)
    mkEnableOption
    mkMerge
    mkIf
    mkOption
    types
    ;
in
{
  options.backup' = {
    restic-backup = {
      enable = mkEnableOption "restic-backup";
      includeDir = mkOption {
        type = types.listOf types.str;
        default = [ "/" ];
      };
      excludeDir = mkOption {
        type = types.listOf types.str;
        default = [ ];
      };
    };
    restic-server.enable = mkEnableOption "restic-server";
  };
  config = mkMerge [
    mkIf
    backup-cfg.enable
    {
      services.restic.backups = {
        initialize = true;
        paths = backup-cfg.includeDir;
        exclude = backup-cfg.excludeDir;
        # FIXME Need to fit actual enviroment
        repository = "/tmp/backup";
        passwordFile = "/tmp/restic/password";
      };
    }
    mkIf
    server-cfg.enable
    {
      services.restic.server = {
        enable = true;
        # FIXME Need to fit actual enviroment
        htpasswd-file = "/tmp/restic/htpasswd";
      };
      networking.firewall = {
        allowedTCPPorts = [ 8000 ];
        allowedUDPPorts = [ 8000 ];
      };
    }
  ];
}
