{
  osConfig,
  lib,
  pkgs,
  ...
}:
let
  cfg = osConfig.programs.niri;
in
{
  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;
      image = pkgs.fetchurl {
        url = "https://github.com/NixOS/nixos-artwork/blob/master/wallpapers/NixOS-Gradient-grey.png?raw=true";
      };
    };
  };
}
