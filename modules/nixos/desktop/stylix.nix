{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.niri;
in
{
  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;
      image = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/03c6c20be96c38827037d2238357f2c777ec4aa5/wallpapers/nix-wallpaper-dracula.png";
        hash = "sha256-SykeFJXCzkeaxw06np0QkJCK28e0k30PdY8ZDVcQnh4=";
      };
      base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-hard.yaml";
      autoEnable = false;
      targets = {
        bat.enable = true;
        chromium.enable = true;
        fcitx5.enable = true;
        fish.enable = true;
        fnott.enable = true;
        fuzzel.enable = true;
        fzf.enable = true;
        gnome.enable = true;
        gtk.enable = true;
        hyprlock.enable = true;
        hyprpaper.enable = true;
        starship.enable = true;
      };
    };
  };
}
