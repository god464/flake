{ config, lib, ... }:
let
  cfg = config.services'.beesd;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.services'.beesd.enable = mkEnableOption "beesd";
  config = mkIf cfg.enable {
    services.beesd.filesystems = {
      root = {
        spec = "LABEL=NixOS";
        hashTableSizeMB = 4096;
      };
    };
  };
}
