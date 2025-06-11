{ osConfig, lib, ... }:
let
  cfg = osConfig.programs.niri;
in
{
  config = lib.mkIf cfg.enable {
    services.hyprpaper.enable = true;
    systemd.user.services.hyprpaper.wantedBy = [ "niri.service" ];
  };
}
