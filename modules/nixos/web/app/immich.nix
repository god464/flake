{ config, lib, ... }:
let
  cfg = config.web'.app.immich;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.web'.app.immich.enable = mkEnableOption "immich";
  config = mkIf cfg.enable {
    services = {
      immich.enable = true;
      nginx.virtualHosts.localhost.locations."/" = {
        proxyPass = "http://localhost:2283/";
        proxyWebsockets = true;
      };
    };
  };
}
