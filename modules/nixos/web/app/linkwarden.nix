{ config, lib, ... }:
let
  cfg = config.web'.app.linkwarden;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.web'.app.linkwarden.enable = mkEnableOption "linkwarden";
  config = mkIf cfg.enable {
    services = {
      linkwarden.enable = true;
      nginx.virtualHosts.localhost.locations."/bookmark/".proxyPass = "http://localhost:3000/";
    };
  };
}
