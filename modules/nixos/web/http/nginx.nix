{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.web'.http.nginx;
  inherit (lib) mkEnableOption;
in
{
  options.web'.http.nginx = {
    enable = mkEnableOption "nginx";
  };
  config = lib.mkIf cfg.enable {
    services = {
      nginx = {
        enable = true;
        enableQuicBPF = true;
        package = pkgs.nginxQuic;
        recommendedOptimisation = true;
        recommendedProxySettings = true;
      };
      prometheus.exporters.nginx.enable = true;
    };
    networking.firewall.allowedTCPPorts = [
      80
      443
    ];
  };
}
