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
      targets = {
        gtk.enable = true;
        qt.enable = true;
        plymouth.enable = true;
        console.enable = true;
        kmscon.enable = true;
        nixos-icons.enable = true;
        limine.enable = true;
        regreet.enable = true;
      };
    };
  };
}
