{ config, lib, ... }:
let
  cfg = config.services.displayManager;
  inherit (lib) mkIf;
in
{
  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      policies = {
        DisableAppUpdate = true;
        DisablePocket = true;
        NoDefaultBookmarks = true;
      };
    };
  };
}
