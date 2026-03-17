{ config, lib, ... }:
let
  cfg = config.services'.monitor.prometheus;
  inherit (lib) mkEnableOption mkIf;
  alert =
    name: expr: extra:
    {
      alert = name;
      inherit expr;
    }
    // extra;
  withFor = attrs: time: attrs // { for = time; };
  critical.labels.severity = "critical";
  warning.labels.severity = "warning";
  alertRules = [
    (alert "NodeDown" "up == 0" (withFor critical "5m"))
    (alert "UnitFailed" ''node_systemd_unit_state{state="failed"} == 1'' warning)
    (alert "OOM" "node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes < 0.15" (
      withFor critical "2m"
    ))
    (alert "SwapUsage" "node_memory_SwapFree_bytes / node_memory_SwapTotal_bytes < 0.5" (
      withFor warning "5m"
    ))
    (alert "CPUHighUsage"
      ''1 - avg by (instance) (rate(node_cpu_seconds_total{mode="idle"}[5m])) > 0.85''
      (withFor warning "5m")
    )
    (alert "FileDescriptorUsage" "node_filefd_allocated / node_filefd_maximum > 0.8" (
      withFor warning "5m"
    ))
    (alert "DiskFull"
      ''node_filesystem_avail_bytes{mountpoint="/"} / node_filesystem_size_bytes < 0.15''
      (withFor critical "5m")
    )
    (alert "BtrfsDevErr" "sum(rate(node_btrfs_device_errors_total[2m])) > 0" critical)
    (alert "TooManyProcesses" "node_procs_running > 500" (withFor warning "10m"))
  ];
in
{
  options.services'.monitor.prometheus.enable = mkEnableOption "prometheus";
  config = mkIf cfg.enable {
    services.prometheus = {
      enable = true;
      listenAddress = "127.0.0.1";

      exporters.node = {
        enable = true;
        enabledCollectors = [
          "systemd"
          "process"
        ];
      };
      rules = [
        (builtins.toJSON {
          groups = [
            {
              name = "system";
              rules = alertRules;
            }
          ];
        })
      ];
      alertmanager = {
        enable = true;
        configuration = {
          receivers = [
            {
              name = "default";
              webhook_configs = [
                { url = "http://127.0.0.1:5001/"; }
              ];
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
