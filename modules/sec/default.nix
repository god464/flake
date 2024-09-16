{ lib, config, ... }:
let
  cfg = config.sec;
  inherit (lib) mkOption mkEnableOption types;
in
{
  options.sec = {
    # TODO
    secret = {
      name = mkOption {
        type = types.str;
      };
      needBoot = mkEnableOption "sops";
    };
  };
  config = {
    sops = {
      age.keyFile = "/var/lib/key.txt";
      defaultSopsFile = ./secrets.yaml;
      secrets.passwd.neededForUsers = true;
    };
    services.dbus.apparmor = "enabled";
    security = {
      apparmor = {
        enable = true;
        killUnconfinedConfinables = true;
      };
      sudo = {
        enable = true;
        execWheelOnly = true;
      };
      auditd.enable = true;
      audit.enable = true;
    };
  };
}
