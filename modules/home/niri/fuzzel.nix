{ osConfig, lib, ... }:
let
  cfg = osConfig.programs.niri;
in
{
  config = lib.mkIf cfg.enable {
    programs.fuzzel = {
      # enable = true;
      settings.main = {
        font = lib.mkForce "Maple Mono Normal CN=13";
        lines = 10;
      };
    };
  };
}
