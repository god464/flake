{ config, lib, ... }:
let
  inherit (lib) mkOption mkEnableOption mkMerge;
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
  config = {
    services.openssh = mkMerge [
      {
        enable = true;
        hostKeys = [
          {
            path = cfg.hostKey;
            type = "ed25519";
          }
        ];
        startWhenNeeded = true;
        settings.UseDns = true;
      }
      (
        if cfg.enable then
          {
            settings.PermitRootLogin = "yes";
          }
        else
          {
            openFirewall = false;
            settings.PermitRootLogin = "no";
          }
      )
    ];
  };
}
