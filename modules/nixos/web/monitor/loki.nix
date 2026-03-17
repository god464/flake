{ config, lib, ... }:
let
  cfg = config.services'.monitor.loki;
  inherit (lib) mkEnableOption mkIf;
  lokiDir = "/var/lib/loki";
in
{
  options.services'.monitor.loki.enable = mkEnableOption "loki";
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
          schema_config.configs = [
            {
              from = "2020-01-01";
              store = "tsdb";
              object_store = "filesystem";
              schema = "v13";
              index = {
                prefix = "index_";
                period = "24h";
              };
            }
          ];
          ingester = {
            lifecycler = {
              address = "127.0.0.1";
              ring = {
                kvstore.store = "inmemory";
                replication_factor = 1;
              };
              final_sleep = "0s";
            };
            chunk_idle_period = "5m";
            chunk_retain_period = "30s";
          };
          storage_config = {
            tsdb_shipper = {
              active_index_directory = "${lokiDir}/tsdb-index";
              cache_location = "${lokiDir}/tsdb-cache";
              cache_ttl = "24h";
            };
            filesystem.directory = "${lokiDir}/chunks";
          };
          limits_config.retention_period = "168h";
          compactor = {
            working_directory = lokiDir;
            retention_enabled = true;
            delete_request_store = "filesystem";
            compactor_ring.kvstore.store = "inmemory";
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
          clients = [ { url = "http://127.0.0.1:3200/loki/api/v1/push"; } ];
          scrape_configs = [
            {
              job_name = "journal";
              journal = {
                json = true;
                max_age = "24h";
                labels.job = "systemd-journal";
              };
            }
            {
              job_name = "syslog";
              static_configs = [
                {
                  targets = [ "localhost" ];
                  labels = {
                    job = "varlogs";
                    __path__ = "/var/log/*.log";
                  };
                }
              ];
            }
          ];
        };
      };
      nginx.virtualHosts.localhost.locations."/loki/".proxyPass = "http://localhost:3200";
    };
  };
}
