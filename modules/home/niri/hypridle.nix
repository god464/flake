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
            timeout = map (x: x) [
              500
              800
              1300
              2100
            ];
            ontimeout = "systemd-ac-power|| systemctl hibernation";
          }
        ];
      };
    };
  };
}
