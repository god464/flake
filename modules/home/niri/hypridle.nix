{ osConfig, lib, ... }:
let
  cfg = osConfig.programs.niri;
in
{
  config = lib.mkIf cfg.enable {
    services.hypridle.enable = true;
    systemd.user.services.hypridle.wantedBy = [ "niri.service" ];
  };
}
