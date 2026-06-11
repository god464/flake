{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.desktop'.niri;
in
{
  imports = with inputs; [ niri-flake.nixosModules.niri ];
  options.desktop'.niri.enable = mkEnableOption "niri";
  config = mkIf cfg.enable {
    programs = {
      niri = {
        enable = true;
        package = pkgs.niri-unstable;
      };
      regreet.enable = true;
    };
    services = {
      # displayManager.ly.enable = true;
      gnome.sushi.enable = true;
    };
    security.pam.services.login.enableGnomeKeyring = true;
    systemd.user.services.niri-flake-polkit.enable = false;
  };
}
