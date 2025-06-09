{ pkgs, ... }:
{
  config = {
    programs.kitty = {
      enable = true;
      font = {
        package = pkgs.maple-mono.Normal-CN;
        name = "Maple Mono Normal CN";
        size = 13.0;
      };
      themeFile = "everforest_dark_hard";
      settings = {
        copy_on_select = true;
        enabled_layouts = "Splits, Stack";
        enable_audio_bell = false;
        tab_bar_edge = "top";
        tab_bar_style = "powerline";
        tab_powerline_style = "round";
        background_opacity = 0.8;
        disable_ligatures = "cursor";
      };
    };
  };
}
