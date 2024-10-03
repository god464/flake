{ lib, config, ... }:
let
  inherit (lib)
    mkOption
    mkMerge
    mkIf
    types
    ;
  cfg = config.sec;
in
{
  options.sec.type = mkOption {
    type = types.enum [
      "age"
      "ssh"
    ];
    default = "ssh";
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
    };
    services.dbus.apparmor = "enabled";
    security = {
      sudo.execWheelOnly = true;
      apparmor.enable = true;
    };
  };
}
