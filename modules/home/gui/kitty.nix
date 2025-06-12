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
      };
      settings = {
        copy_on_select = true;
        enabled_layouts = "splits, stack";
        enable_audio_bell = false;
        tab_bar_edge = "top";
        tab_bar_style = "powerline";
        tab_powerline_style = "round";
        disable_ligatures = "cursor";
      };
    };
  };
}
