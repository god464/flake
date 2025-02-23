{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.web'.sql.postgresql;
  inherit (lib) mkEnableOption;
in
{
  options.web'.sql.mysql.enable = mkEnableOption "mysql";
  config = lib.mkIf cfg.enable {
    services.mysql = {
      enable = true;
      dataDir = "/var/lib/mysql";
      package = pkgs.mariadb;
    };
  };
}
