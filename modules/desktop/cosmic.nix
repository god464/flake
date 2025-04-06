{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.desktop'.cosmic;
  inherit (lib) mkEnableOption mkIf;
in
{

  options.desktop'.cosmic.enable = mkEnableOption "cosmic";
  config = mkIf cfg.enable {
    services = {
      desktopManager.cosmic.enable = true;
      displayManager.cosmic-greeter.enable = true;
    };
    environment.systemPackages = [ pkgs.wl-clipboard ];
  };

}
