{ config, lib, ... }:
let
  cfg = config.web'.app.linkwarden;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.web'.app.linkwarden.enable = mkEnableOption "linkwarden";
  config = mkIf cfg.enable {
    sops.secrets.nextauth_key = { };
    services = {
      linkwarden = {
        enable = true;
        secretFiles = {
          NEXTAUTH_SECRET = config.sops.secrets.nextauth_key.path;
          MEILI_MASTER_KEY = config.sops.secrets.master_key.path;
        };
      };
      nginx.virtualHosts.localhost.locations."/bookmark/".proxyPass = "http://localhost:3000/";
    };
  };
}
