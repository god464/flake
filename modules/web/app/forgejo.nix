{ config, lib, ... }:
let
  cfg = config.web'.app.forgejo;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.web'.app.forgejo.enable = mkEnableOption "forgejo";
  config = mkIf cfg.enable {
    services.forgejo = {
      enable = true;
      database.type = "postgres";
    };
    networking.firewall.allowedTCPPorts = [ 3000 ];
  };
}
