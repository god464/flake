{ lib, config, ... }:
let
  inherit (lib) mkOption mkEnableOption types;
in
{
  options.sec = {
    # TODO
    secret = {
      name = mkOption { type = types.str; };
      needBoot = mkEnableOption "sops";
    };
  };
  config = {
    sops = {
      age.keyFile = "/var/lib/sops-nix/keys.txt";
      defaultSopsFile = ./secrets.yaml;
      secrets.passwd.neededForUsers = true;
    };
    services.dbus.apparmor = "enabled";
    security.sudo.execWheelOnly = true;
  };
}
