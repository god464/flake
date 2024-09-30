{ lib, config, ... }:
let
  inherit (lib)
    mkOption
    mkEnableOption
    mkMerge
    mkIf
    types
    ;
  cfg = config.sec;
in
{
  options.sec = {
    # TODO
    type = mkOption {
      type = types.enum [
        "age"
        "ssh"
      ];
      default = "ssh";
    };
    secret = {
      name = mkOption { type = types.str; };
      needBoot = mkEnableOption "needBoot";
    };
  };
  config = {
    sops = {
      age = mkMerge [
        (mkIf (cfg.type == "age") {
          keyFile = "/var/lib/sops-nix/keys.txt";
        })
        (mkIf (cfg.type == "ssh") {
          sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
        })
      ];
      defaultSopsFile = ./secrets.yaml;
      secrets.passwd.neededForUsers = true;
    };
    services.dbus.apparmor = "enabled";
    security.sudo.execWheelOnly = true;
  };
}
