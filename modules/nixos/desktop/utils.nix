{ config, lib, ... }:
let
  cfg = config.services.displayManager;
  inherit (lib) mkIf;
in
{
  config = mkIf cfg.enable {
    services = {
      fwupd.enable = true;
      tlp.enable = true;
      udisks2 = {
        enable = true;
        mountOnMedia = true;
      };
    };
    security.polkit.enable = true;
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
