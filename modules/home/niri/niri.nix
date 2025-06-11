{ osConfig, lib, ... }:
let
  cfg = osConfig.programs.niri;
in
{
  config = lib.mkIf cfg.enable {
    programs.niri.config = builtins.readFile ./niri.settings.kdl;
  };
}
