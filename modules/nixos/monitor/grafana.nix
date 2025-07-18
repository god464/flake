{ config, lib, ... }:
let
  cfg = config.monitor'.grafana;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.monitor'.grafana.enable = mkEnableOption "grafana";
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
      nginx.virtualHosts.localhost.locations."/grafana/".proxyPass = "http://localhost:3000";
    };
  };
}
