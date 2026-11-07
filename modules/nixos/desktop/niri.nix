{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.desktop'.niri;
in
{
  options.desktop'.niri.enable = mkEnableOption "niri";
  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.wl-clipboard-rs ];
    programs = {
      niri.enable = true;
      noctalia = {
        enable = true;
        recommendedServices.enable = true;
        systemd.enable = true;
      };
    };
    services = {
      oo7.enable = true;
      displayManager.noctalia-greeter = {
        enable = true;
        passwordlessSyncUsers = [ "cl" ];
        cursorTheme = {
          name = "Bibata-Modern-Classic";
          package = pkgs.bibata-cursors;
        };
      };
      gnome.sushi.enable = true;
    };
  };
}
