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
    services.fnoot.enable = true;
    systemd.user.services.fuzzel.wantedBy = [ "niri.service" ];
  };
}
