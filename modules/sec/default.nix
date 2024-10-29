{ lib, config, ... }:
let
  inherit (lib) mkMerge mkEnableOption mkIf;
  cfg = config.sec;
in
{
  options.sec.useAge = mkEnableOption "useAge";
  config = {
    sops = {
      age = mkMerge [
        (mkIf cfg.useAge { keyFile = "/var/lib/sops-nix/keys.txt"; })
        {
          sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
          generateKey = true;
        }
      ];
    };
    services.dbus.apparmor = "enabled";
    security = {
      sudo.execWheelOnly = true;
      apparmor.enable = true;
    };
  };
}
