{ config, lib, ... }:
let
  cfg = config.web'.app.grafana;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.web'.app.grafana.enable = mkEnableOption "grafana";
  config = mkIf cfg.enable {
    services = {
      grafana = {
        enable = true;
        settings.server = {
          enable_gzip = true;
          root_url = "%(protocol)s://%(domain)s:%(http_port)s/monitor/";
          serve_from_sub_path = true;
        };
      };
      nginx.virtualHosts.localhost.locations."/photo/".proxyPass = "http://localhost:3000/";
    };
  };
}
