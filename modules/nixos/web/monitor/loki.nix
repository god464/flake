{ config, lib, ... }:
let
  cfg = config.web'.monitor.loki;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.web'.monitor.loki.enable = mkEnableOption "loki";
  config = mkIf cfg.enable {
    services = {
      loki = {
        enable = true;
        configuration = {
          analytics.reporting_enabled = false;
          auth_enabled = false;
          server = {
            http_listen_address = "0.0.0.0";
            http_listen_port = 3200;
            log_level = "warn";
          };
        };
      };
      promtail = {
        enable = true;
        configuration = {
          server = {
            http_listen_port = 9080;
            grpc_listen_port = 0;
            log_level = "warn";
          };
          scrape_configs = [ ];
        };
      };
      nginx.virtualHosts.localhost.locations."/loki/".proxyPass = "http://localhost:3200";
    };
  };
}
