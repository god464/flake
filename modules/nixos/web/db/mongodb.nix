{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.web'.db.mongodb;
  inherit (lib) mkEnableOption;
in
{
  options.web'.db.mongodb.enable = mkEnableOption "mongodb";
  config = lib.mkIf cfg.enable {
    services = {
      mongodb = {
        enable = true;
        package = pkgs.mongodb-ce;
      };
      prometheus.exporters.mongodb.enable = true;
    };
  };
}
