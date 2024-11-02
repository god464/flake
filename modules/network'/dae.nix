{ config, lib, ... }:
let
  cfg = config.network'.dae;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.network'.dae.enable = mkEnableOption "dae";
  config = mkIf cfg.enable {
    sops = {
      secrets.config-dae = {
        format = "binary";
        sopsFile = ./config.dae;
      };
    };
    services.dae = {
      enable = true;
      configFile = config.sops.secrets.config-dae.path;
    };
  };
}
