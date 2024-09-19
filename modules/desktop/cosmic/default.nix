{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.desktop.cosmic;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.desktop.cosmic = {
    enable = mkEnableOption "cosmic";
  };
  config = mkIf cfg.enable {
    services = {
      desktopManager.cosmic.enable = true;
      displayManager.cosmic-greeter.enable = true;
      pipewire = {
        enable = true;
        alsa.enable = true;
        pulse.enable = true;
        jack.enable = true;
        wireplumber.enable = true;
      };
    };
    programs = {
      firefox = {
        enable = true;
        policies = {
          DisableAccounts = true;
          DisableAppUpdate = true;
          DisablePocket = true;
          NoDefaultBookmarks = true;
        };
      };
      thunderbird = {
        enable = true;
        policies.DisableAppUpdate = true;
      };
    };
    security.polkit.enable = true;
    environment.systemPackages = lib.mkAfter ([ pkgs.wl-clipboard ]);
  };
}
