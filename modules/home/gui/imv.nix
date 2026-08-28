{ osConfig, lib, ... }:
let
  cfg = osConfig.services.displayManager;
in
{
  config = lib.mkIf cfg.enable { programs.imv.enable = true; };
}
