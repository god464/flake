{ osConfig, lib, ... }:
let
  cfg = osConfig.programs.niri;
in
{
  config = lib.mkIf cfg.enable {
    programs.fuzzel = {
      settings.main.font = lib.mkForce "Maple Mono Normal CN=13";
      enable = true;
    };
  };
}
