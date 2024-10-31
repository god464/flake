{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkMerge;
  cfg = config.services'.ssh;
in
{
  options.services'.ssh.enable = mkEnableOption "ssh";
  config = {
    services.openssh = mkMerge [
      {
        enable = true;
        startWhenNeeded = true;
      }
      (
        if cfg.enable then
          {
            settings.PermitRootLogin = "yes";
          }
        else
          {
            openFirewall = false;
          }
      )
    ];
  };
}
