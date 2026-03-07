{ config, lib, ... }:
let
  cfg = config.web'.storage.postgresql;
  inherit (lib) mkEnableOption;
in
{
  options.web'.storage.postgresql.enable = mkEnableOption "postgresql";
  config = lib.mkIf cfg.enable {
    services = {
      postgresql = {
        enable = true;
        enableTCPIP = true;
        enableJIT = true;
      };
      prometheus.exporters.postgres.enable = true;
    };
  };
}
