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
        package = pkgs.candy-icons;
        dark = "candy-icons";
        light = "candy-icons";
      };
      targets = {
        bat.enable = true;
        fcitx5.enable = true;
        fzf.enable = true;
        gdu.enable = true;
        starship.enable = true;
        mpv.enable = true;
        yazi.enable = true;
        tmux.enable = true;
      };
    };
  };
}
