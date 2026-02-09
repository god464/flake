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
  imports = with inputs; [
    niri-flake.nixosModules.niri
    dankMaterialShell.nixosModules.dank-material-shell
    dankMaterialShell.nixosModules.greeter
  ];
  options.desktop'.niri.enable = mkEnableOption "niri";
  config = mkIf cfg.enable {
    programs = {
      niri = {
        enable = true;
        package = pkgs.niri-unstable;
      };
      dank-material-shell = {
        enable = true;
        quickshell.package = inputs.quickshell.packages."x86_64-linux".quickshell;
        greeter = {
          enable = true;
          compositor.name = "niri";
        };
      };
    };
    services.gnome.sushi.enable = true;
    security.pam.services = {
      login = {
        enableGnomeKeyring = true;
        googleAuthenticator.enable = true;
      };
      greeter.googleAuthenticator.enable = true;
    };
    systemd.user.services.niri-flake-polkit.enable = false;
  };
}
