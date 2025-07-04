{ osConfig, lib, ... }:
let
  cfg = osConfig.services.displayManager;
in
{
  config = lib.mkIf cfg.enable {
    programs.librewolf = {
      enable = true;
      policies = {
        DisableAppUpdate = true;
        DisablePocket = true;
        NoDefaultBookmarks = true;
      };
    };
  };
}
