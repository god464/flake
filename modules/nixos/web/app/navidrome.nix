{ config, lib, ... }:
let
  cfg = config.web'.app.navidrome;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.web'.app.navidrome.enable = mkEnableOption "navidrome";
  config = mkIf cfg.enable {
    services = {
      navidrome.enable = true;
      nginx.virtualHosts.localhost.locations."/music/".proxyPass = "http://localhost:4533/";
    };
  };
}
