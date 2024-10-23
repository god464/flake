{ config, lib, ... }:
let
  cfg = config.dae;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.dae.enable = mkEnableOption "dae";
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
