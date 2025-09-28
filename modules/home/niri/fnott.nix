{ osConfig, lib, ... }:
let
  cfg = osConfig.programs.niri;
in
{
  config = lib.mkIf cfg.enable {
    services.fnott = {
      enable = true;
      settings.main = {
        default-timeout = 15;
        max-timeout = 15;
        idle-timeout = 15;
      };
    };
  };
}
