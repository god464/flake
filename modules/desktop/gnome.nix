{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.desktop'.gnome;
in
{
  options.desktop'.gnome.enable = mkEnableOption "Gnome";
  config = mkIf cfg.enable {
    services = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
    environment.systemPackages = with pkgs; [ gnome-tweaks ];
  };
}
