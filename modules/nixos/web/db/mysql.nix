{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.web'.db.mysql;
  inherit (lib) mkEnableOption;
in
{
  options.web'.db.mysql.enable = mkEnableOption "mysql";
  config = lib.mkIf cfg.enable {
    services = {
      mysql = {
        enable = true;
        dataDir = "/var/lib/mysql";
        package = pkgs.mysql;
      };
      prometheus.exporters.mysqld.enable = true;
    };
  };
}
