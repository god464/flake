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
      gnome.sushi.enable = true;
      gnome.evolution-data-server.enable = true;
    };
    security.pam.services.login.enableGnomeKeyring = true;
    systemd.user.services.niri-flake-polkit.enable = false;
  };
}
