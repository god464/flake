{ osConfig, lib, ... }:
let
  cfg = osConfig.services.displayManager;
in
{
  config = lib.mkIf cfg.enable {
    programs.ghostty = {
      enable = true;
      settings = {
        theme = "catppuccin-mocha";
        font-family = "Maple Mono Normal CN";
        font-size = 13.0;
        background-opacity = 0.8;
      };
    };
  };
}
