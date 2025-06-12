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
        url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/3f7695afe75239720a32d6c38df7c9888b5ed581/wallpapers/NixOS-Gradient-grey.png";
        hash = "sha256-Tf4Xruf608hpl7YwL4Mq9l9egBOCN+W4KFKnqrgosLE=";
      };
      base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-hard.yaml";
      opacity = {
        terminal = 0.8;
        desktop = 0.8;
        popups = 0.8;
      };
      cursor = {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
        size = 24;
      };
      fonts = {
        sizes.terminal = 13.0;
        serif = {
          package = pkgs.source-han-serif;
          name = "Source Han Serif SC";
        };
        sansSerif = {
          package = pkgs.source-han-sans;
          name = "Source Han Sans SC";
        };
        monospace = {
          package = pkgs.source-han-mono;
          name = "Source Han Mono SC";
        };
        emoji = {
          package = pkgs.twemoji-color-font;
          name = "Twitter Color Emoji";
        };
      };
      polarity = "dark";
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
