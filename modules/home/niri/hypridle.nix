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
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "/run/current-system/systemd/bin/loginctl lock-session";
        };
        listener = [
          {
            timeout = 120;
            on-timeout = "/run/current-system/systemd/bin/loginctl lock-session";
          }
          {
            timeout = 300;
            on-timeout = "/run/current-system/systemd/bin/systemctl suspend";
          }
          (map
            (x: {
              timeout = x;
              ontimeout = "systemd-ac-power|| systemctl hibernation";
            })
            [
              600
              1800
              5400
              7200
              9000
            ]
          )
        ];
      };
    };
  };
}
