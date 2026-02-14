{
  osConfig,
  lib,
  pkgs,
  ...
}:
let
  cfg = osConfig.programs'.zen;
in
{
  config = lib.mkIf cfg.enable {
    programs.zen-browser = {
      enable = true;
      nativeMessagingHosts = [ pkgs.firefoxpwa ];
      policies = {
        DisableAppUpdate = true;
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
      profiles.default = { };
    };
  };
}
