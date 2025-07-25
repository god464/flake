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
      autoEnable = false;
      overlays.enable = lib.mkForce true;
      iconTheme = {
        enable = true;
        package = pkgs.papirus-icon-theme;
        dark = "Papirus-Dark";
        light = "Papirus-Light";
      };
      targets = {
        bat.enable = true;
        fcitx5.enable = true;
        firefox = {
          enable = true;
          colorTheme.enable = true;
          firefoxGnomeTheme.enable = true;
        };
        fnott.enable = true;
        fuzzel.enable = true;
        fzf.enable = true;
        hyprlock.enable = true;
        hyprpaper.enable = true;
        kitty.enable = true;
        starship.enable = true;
        waybar.enable = true;
        mpv.enable = true;
        zathura.enable = true;
        yazi.enable = true;
        nixos-icons.enable = true;
        eog.enable = true;
      };
    };
  };
}
