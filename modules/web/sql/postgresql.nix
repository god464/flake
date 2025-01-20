{ config, lib, ... }:
let
  cfg = config.web'.sql.postgresql;
  inherit (lib) mkOption mkEnableOption types;
in
{
  options.web'.sql.postgresql = {
    enable = mkEnableOption "postgresql";
    db = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };
  };
  config = lib.mkIf cfg.enable {
    services.postgresql = {
      enable = true;
      enableTCPIP = true;
      enableJIT = true;
      ensureDatabases = cfg.db;
    };
  };
}
