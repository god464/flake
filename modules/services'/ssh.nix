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
    home-manager.users.cl.programs.ssh = {
      enable = true;
      forwardAgent = true;
      addKeysToAgent = "yes";
    };
    environment.persistence."/persist".users.cl.directories = [
      {
        directory = ".ssh";
        mode = "700";
      }
    ];
  };
}
