{ config, lib, ... }:
let
  cfg = config.web'.sql.postgresql;
  inherit (lib) mkEnableOption;
in
{
  options.web'.sql.postgresql.enable = mkEnableOption "postgresql";
  config = lib.mkIf cfg.enable {
    services.postgresql = {
      enable = true;
      enableTCPIP = true;
      enableJIT = true;
    };
  };
}
