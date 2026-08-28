{ osConfig, lib, ... }:
let
  cfg = osConfig.services.displayManager;
in
{
  config = lib.mkIf cfg.enable {
    programs.zathura = {
      enable = true;
      options.selection-clipboard = "clipboard";
    };
  };
}
