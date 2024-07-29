{ config, lib, ... }:
let
  cfg = config.sec;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.sec = {
    enable = mkEnableOption "sec";
  };
  config = mkIf cfg.enable {
    sops = {
      age = {
        keyFile = "/var/lib/key.txt";
        generateKey = true;
      };
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
