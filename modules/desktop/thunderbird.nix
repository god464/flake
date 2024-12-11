{ config, lib, ... }:
let
  cfg = config.services.displayManager;
  inherit (lib) mkIf;
in
{
  config = mkIf cfg.enable {
    programs.thunderbird = {
      enable = true;
      policies.DisableAppUpdate = true;
    };
  };
}
