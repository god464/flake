{ config, lib, ... }:
let
  cfg = config.network'.mihomo;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.network'.mihomo.enable = mkEnableOption "mihomo";
  config = mkIf cfg.enable {
    services.mihomo = {
      enable = true;
      tunMode = true;
    };
  };
}
