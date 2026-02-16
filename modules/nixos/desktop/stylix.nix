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
      polarity = "dark";
      image = ../../../assests/bg.png;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      overlays.enable = true;
      opacity = {
        terminal = 0.8;
        desktop = 0.8;
        popups = 0.8;
      };
      cursor = {
        name = "Bibata-Modern-Classic";
        package = pkgs.bibata-cursors;
        size = 20;
      };
      fonts = {
        sizes.terminal = 13.0;
        serif = {
          package = pkgs.apple-pingfang;
          name = "PingFang SC";
        };
        sansSerif = {
          package = pkgs.apple-new-york;
          name = "New York Medium";
        };
        monospace = {
          package = pkgs.apple-sf-mono;
          name = "SF Mono";
        };
        emoji = {
          package = pkgs.apple-color-emoji;
          name = "Apple Color Emoji";
        };
      };
      targets = {
        gtk.enable = true;
        qt.enable = true;
        plymouth.enable = true;
        console.enable = true;
        kmscon.enable = true;
        nixos-icons.enable = true;
      };
    };
  };
}
