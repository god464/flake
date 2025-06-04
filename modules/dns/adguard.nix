{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.dns'.adguard;
in
{
  options.dns'.adguard.enable = mkEnableOption "adguard";
  config = mkIf cfg.enable {
    services = {
      adguardhome = {
        enable = true;
        port = 3001;
      };
      nginx.virtualHosts.localhost.locations."/adguard/".proxyPass = "http://localhost:3001/";
    };
  };
}
