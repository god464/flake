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
      icons = {
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
          profileNames = [ "default" ];
        };
        fzf.enable = true;
        gdu.enable = true;
        starship.enable = true;
        mpv.enable = true;
        yazi.enable = true;
        tmux.enable = true;
      };
    };
    programs.firefox = {
      enable = true;
      profiles.default = { };
    };
  };
}
