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
            timeout = 90;
            on-timeout = "/run/current-system/systemd/bin/loginctl lock-session";
          }
          {
            timeout = 300;
            on-timeout = "/run/current-system/systemd/bin/systemctl suspend";
          }
          {
            timeout = 600;
            ontimeout = ''
              if [[ "cat /sys/class/power_supply/ACAD/online == 1" ]]
              then
                systemctl hibernation
            '';
          }
        ];
      };
    };
  };
}
