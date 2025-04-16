{ config, lib, ... }:
let
  cfg = config.web'.app.grafana;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.web'.app.grafana.enable = mkEnableOption "grafana";
  config = mkIf cfg.enable {
    services.grafana = {
      enable = true;
      settings.server.enable_gzip = true;
    };
  };
}
