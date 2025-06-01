{
  inputs,
  lib,
  config,
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
    nixpkgs.overlays = [ inputs.niri.overlays.niri ];
    programs = {
      niri = {
        enable = true;
        package = pkgs.niri-stable;
      };
      waybar.enable = true;
    };
    services.displayManager.gdm.enable = true;
  };
}
