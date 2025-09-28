{
  osConfig,
  lib,
  pkgs,
  ...
}:
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
          before_sleep_cmd = "loginctl lock-session";
        };
        listener = [
          {
            timeout = 150;
            on-timeout = "${lib.getExe pkgs.brightnessctl} -s set 10 ";
            on-resume = "${lib.getExe pkgs.brightnessctl} -r";
          }
          {
            timeout = 300;
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 420;
            on-timeout = "systemctl suspend";
          }
        ]
        ++ (map
          (x: {
            timeout = x;
            ontimeout = "systemd-ac-power || systemctl hibernation";
          })
          [
            600
            1800
            5400
            7200
            9000
          ]
        );
      };
    };
  };
}
