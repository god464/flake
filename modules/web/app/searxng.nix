{ config, lib, ... }:
let
  cfg = config.web'.app.searxng;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.web'.app.searxng.enable = mkEnableOption "searxng";
  config = mkIf cfg.enable {
    services.searx = {
      enable = true;
      redisCreateLocally = true;
    };
  };
}
