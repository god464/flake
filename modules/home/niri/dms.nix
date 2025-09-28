{ osConfig, lib, ... }:
let
  cfg = osConfig.programs.niri;
in
{
  config = lib.mkIf cfg.enable {
    programs.dankMaterialShell = {
      # enable = true;
      # enableSystemd = true;
      # niri.enableKeybinds = true;
    };
  };
}
