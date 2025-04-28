{ config, lib, ... }:
let
  cfg = config.monitor'.prometheus;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.monitor'.prometheus.enable = mkEnableOption "prometheus";
  config = mkIf cfg.enable {
    services.prometheus = {
      enable = true;
      listenAddress = "127.0.0.1";
      exporters = {
        node = {
          enable = true;
          enabledCollectors = [ "systemd" ];
        };
      };
    };
  };
}
