{
  pkgs,
  osConfig,
  lib,
  ...
}:
let
  cfg = osConfig.services.displayManager;
in
{
  config = lib.mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      font = {
        package = lib.mkForce pkgs.maple-mono.Normal-CN;
        name = lib.mkForce "Maple Mono Normal CN";
        size = lib.mkForce 13.0;
      };
      themeFile = "everforest_dark_hard";
      settings = {
        copy_on_select = true;
        enabled_layouts = "splits, stack";
        enable_audio_bell = false;
        tab_bar_edge = "top";
        tab_bar_style = "powerline";
        tab_powerline_style = "round";
        background_opacity = lib.mkForce 0.8;
        disable_ligatures = "cursor";
      };
    };
  };
}
