{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.desktop'.niri;
in
{
  options.desktop'.niri.enable = mkEnableOption "niri";
  config = mkIf cfg.enable {
    programs = {
      niri.enable = true;
      noctalia = {
        enable = true;
        recommendedServices.enable = true;
        systemd.enable = true;
      };
    };
    services = {
      displayManager.noctalia-greeter.enable = true;
      gnome.sushi.enable = true;
      gnome.gnome-keyring.enable = true;
    };
    security.pam.services = {
      login.enableGnomeKeyring = true;
      greetd.enableGnomeKeyring = true;
    };
  };
}
