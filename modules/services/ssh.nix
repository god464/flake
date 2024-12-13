{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkMerge;
  inherit (config.sops) secrets;
  cfg = config.services'.ssh;
in
{
  options.services'.ssh.enable = mkEnableOption "ssh";
  config = {
    services.openssh = mkMerge [
      {
        enable = true;
        hostKeys = [
          {
            inherit (secrets.host-rsa) path;
            type = "rsa";
          }
          {
            inherit (secrets.host-ed25519) path;
            type = "ed25519";
          }
          {
            inherit (secrets.host-ecdsa) path;
            type = "ecdsa";
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
