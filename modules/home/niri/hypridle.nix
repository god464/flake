{ osConfig, lib, ... }:
let
  cfg = osConfig.programs.niri;
in
{
  config = lib.mkIf cfg.enable {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "hyprlock";
          before_sleep_cmd = "/run/current-system/systemd/bin/loginctl lock-session";
        };
        listener = [
          {
            timeout = 90;
            on-timeout = "/run/current-system/systemd/bin/loginctl lock-session";
          }
          {
            timeout = 900;
            on-timeout = "/run/current-system/systemd/bin/systemctl suspend";
          }
        ];
      };
    };
  };
}
