{ config, lib, ... }:
let
  cfg = config.network'.clash;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.network'.clash.enable = mkEnableOption "clash";
  config = mkIf cfg.enable {
    programs.clash-verge = {
      enable = true;
      tunMode = true;
      serviceMode = true;
    };
  };
}
