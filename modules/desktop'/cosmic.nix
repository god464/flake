{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.desktop'.cosmic;
  inherit (lib) mkEnableOption mkIf mkAfter;
in
{
  options.desktop'.cosmic = {
    enable = mkEnableOption "cosmic";
  };
  config = mkIf cfg.enable {
    services = {
      desktopManager.cosmic.enable = true;
      displayManager.cosmic-greeter.enable = true;
    };
    security.polkit.enable = true;
    environment.systemPackages = mkAfter [ pkgs.wl-clipboard ];
  };
}
