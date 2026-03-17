{ config, lib, ... }:
let
  inherit (lib) mkOption mkEnableOption;
  cfg = config.services'.ssh;
in
{
  options.services'.ssh = {
    enable = mkEnableOption "ssh";
    hostKey = mkOption {
      type = lib.types.nullOr lib.types.str;
      default = "/etc/ssh/ssh_host_ed25519_key";
    };
  };
  config.services.openssh = {
    enable = true;
    startWhenNeeded = true;
    settings.PasswordAuthentication = false;
    hostKeys = [
      {
        path = cfg.hostKey;
        type = "ed25519";
      }
    ];
    settings.PermitRootLogin = if cfg.enable then "prohibit-password" else "no";
    openFirewall = cfg.enable;
  };
}
