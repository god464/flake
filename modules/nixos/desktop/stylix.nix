{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.niri;
in
{
  imports = [ inputs.stylix.nixosModules.stylix ];
  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;
      autoEnable = false;
      image = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/03c6c20be96c38827037d2238357f2c777ec4aa5/wallpapers/nix-wallpaper-dracula.png";
        hash = "sha256-SykeFJXCzkeaxw06np0QkJCK28e0k30PdY8ZDVcQnh4=";
      };
      base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-hard.yaml";
      opacity.terminal = true;
      overlays.enable = true;
      targets = {
        chromium.enable = true;
        fish.enable = true;
        gnome.enable = true;
        gtk.enable = true;
        qt.enable = true;
        plymouth.enable = true;
      };
    };
  };
}
