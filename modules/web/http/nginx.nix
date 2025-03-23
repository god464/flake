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
    services.nginx = {
      enable = true;
      enableQuicBPF = true;
      package = pkgs.nginxQuic;
      recommendedZstdSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
    };
    networking.firewall.allowedTCPPorts = [
      80
      443
    ];
  };
}
