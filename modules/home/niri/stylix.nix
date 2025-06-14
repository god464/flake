{ osConfig, lib, ... }:
let
  cfg = osConfig.programs.niri;
in
{
  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;
      autoEnable = false;
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
        hyprlock = {
          enable = true;
          useWallpaper = false;
        };
        hyprpaper.enable = true;
        kitty.enable = true;
        starship.enable = true;
        waybar.enable = true;
        mpv.enable = true;
        zathura.enable = true;
        yazi.enable = true;
      };
    };
  };
}
