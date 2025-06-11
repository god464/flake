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
    stylix.nixosModules.stylix
  ];
  options.desktop'.niri.enable = mkEnableOption "niri";
  config = mkIf cfg.enable {
    nixpkgs.overlays = [ inputs.niri-flake.overlays.niri ];
    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };
    services.displayManager.gdm.enable = true;
  };
}
