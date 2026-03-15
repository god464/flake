{ config, lib, ... }:
let
  cfg = config.services'.monitor.prometheus;
  inherit (lib) mkEnableOption mkIf singleton;
in
{
  options.services'.monitor.prometheus.enable = mkEnableOption "prometheus";
  config = mkIf cfg.enable {
    services.prometheus = {
      enable = true;
      listenAddress = "127.0.0.1";
      exporters.node = {
        enable = true;
        enabledCollectors = [ "systemd" ];
      };
      rules = singleton (
        builtins.toJSON {
          groups = [
            {
              name = "system";
              rules = [
                {
                  alert = "NodeDown";
                  expr = ''up == 0'';
                  for = "5m";
                  labels.severity = "critical";
                }
                {
                  alert = "UnitFailed";
                  expr = ''node_systemd_unit_state{state="failed"} == 1'';
                  labels.severity = "warning";
                }
                {
                  alert = "OOM";
                  expr = ''node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes < 0.15'';
                  for = "2m";
                  labels.severity = "critical";
                }
                {
                  alert = "SwapUsage";
                  expr = ''node_memory_SwapFree_bytes / node_memory_SwapTotal_bytes < 0.5'';
                  for = "5m";
                  labels.severity = "warning";
                }
                {
                  alert = "CPUHighUsage";
                  expr = ''1 - avg by (instance) (rate(node_cpu_seconds_total{mode="idle"}[5m])) > 0.85'';
                  for = "5m";
                  labels.severity = "warning";
                }
                {
                  alert = "FileDescriptorUsage";
                  expr = ''node_filefd_allocated / node_filefd_maximum > 0.8'';
                  for = "5m";
                  labels.severity = "warning";
                }
                {
                  alert = "DiskFull";
                  expr = ''node_filesystem_avail_bytes{mountpoint="/"} / node_filesystem_size_bytes < 0.15'';
                  for = "5m";
                  labels.severity = "critical";
                }
                {
                  alert = "InodeUsage";
                  expr = ''node_filesystem_files_free{mountpoint="/"} / node_filesystem_files < 0.1'';
                  for = "5m";
                  labels.severity = "warning";
                }
                {
                  alert = "BtrfsDevErr";
                  expr = ''sum(rate(node_btrfs_device_errors_total[2m])) > 0'';
                  labels.severity = "critical";
                }
                {
                  alert = "TooManyProcesses";
                  expr = ''node_procs_running > 500'';
                  for = "10m";
                  labels.severity = "warning";
                }
              ];
            }
          ];
        }
      );
      alertmanager = {
        enable = true;
        configuration = {
          receivers = [
            {
              name = "default";
              webhook_configs = [ { url = "http://127.0.0.1:5001/"; } ];
            }
          ];
          route = {
            receiver = "default";
            group_by = [ "alertname" ];
            group_wait = "30s";
            group_interval = "5m";
            repeat_interval = "1h";
          };
          inhibit_rules = [
            {
              source_matchers = [ ''severity="critical"'' ];
              target_matchers = [ ''severity="warning"'' ];
              equal = [
                "alertname"
                "dev"
                "instance"
              ];
            }
          ];
        };
      };
    };
  };
}
