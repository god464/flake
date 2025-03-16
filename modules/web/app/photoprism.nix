{ config, lib, ... }:
let
  cfg = config.web'.app.photoprism;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.web'.app.photoprism.enable = mkEnableOption "photoprism";
  config = mkIf cfg.enable {
    services = {
      photoprism = {
        enable = true;
        passwordFile = config.sops.secrets.photoprism.path;
        originalsPath = "/var/lib/private/photoprism/originals";
        address = "0.0.0.0";
        settings = {
          PHOTOPRISM_ADMIN_USER = "admin";
          PHOTOPRISM_DATABASE_DRIVER = "mysql";
          PHOTOPRISM_DATABASE_NAME = "photoprism";
          PHOTOPRISM_DATABASE_SERVER = "/run/mysqld/mysqld.sock";
          PHOTOPRISM_DATABASE_USER = "photoprism";
        };
      };
      mysql = {
        ensureDatabases = [ "photoprism" ];
        ensureUsers = [
          {
            name = "photoprism";
            ensurePermissions = {
              "photoprism.*" = "ALL PRIVILEGES";
            };
          }
        ];
      };
    };
  };
}
