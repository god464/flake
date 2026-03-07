{ config, lib, ... }:
let
  cfg = config.services.displayManager;
  inherit (lib) mkIf;
in
{
  config = mkIf cfg.enable {
    programs.firefox = {
      # enable = true;
      policies = {
        DisableAppUpdate = true;
        DisableTelemetry = true;
        DisablePocket = true;
        DisableFirefoxStudies = true;
        NoDefaultBookmarks = true;
        EnableTrackingProtection = {
          Value = true;
          Cryptomining = true;
          Fingerprinting = true;
          EmailTracking = true;
          SuspectedFingerprinting = true;
        };
      };
    };
  };
}
