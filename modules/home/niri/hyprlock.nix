{
  osConfig,
  lib,
  ...
}:
let
  cfg = osConfig.programs.niri;
in
{
  config = lib.mkIf cfg.enable {
    programs.hyprlock.enable = true;
  };
}
