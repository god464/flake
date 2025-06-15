{ config, lib, ... }:
let
  cfg = config.web'.app.calibre;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.web'.app.calibre.enable = mkEnableOption "calibre";
  config = mkIf cfg.enable {
    services = {
      calibre-web = {
        enable = true;
        options = {
          enableBookUploading = true;
          enableBookConversion = true;
        };
      };
      nginx.virtualHosts.localhost.locations."/calibre/".proxyPass = "http://localhost:8083/";
    };
  };
}
