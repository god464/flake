{ osConfig, lib, ... }:
let
  cfg = osConfig.services.displayManager;
in
{
  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;
      autoEnable = false;
      targets = {
        bat.enable = true;
        bottom.enable = true;
        fcitx5.enable = true;
        fzf.enable = true;
        starship.enable = true;
        mpv.enable = true;
        yazi.enable = true;
        tmux.enable = true;
        zathura.enable = true;
      };
    };
  };
}
