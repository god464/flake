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
  imports = [ inputs.niri-flake.nixosModules.niri ];
  options.desktop'.niri.enable = mkEnableOption "niri";
  config = mkIf cfg.enable {
    programs = {
      niri = {
        enable = true;
        package = pkgs.niri-unstable;
      };
      regreet.enable = true;
    };
    services.gnome.sushi.enable = true;
    security.pam.services.hyprlock.fprintAuth = false;
    environment.systemPackages = with pkgs; [
      wl-clipboard-rs
      nautilus
      eog
      gemini-cli
    ];
  };
}
