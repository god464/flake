{ lib, config, ... }:
let
  inherit (lib)
    mkOption
    types
    mkMerge
    mkIf
    ;
  cfg = config.network'.net;
  display = config.services.displayManager;
in
{
  options.network'.net.name = mkOption { type = types.str; };
  config = {
    networking = mkMerge [
      {
        hostName = cfg.name;
        nftables.enable = true;
        firewall = {
          enable = true;
          checkReversePath = false;
          filterForward = true;
        };
        resolvconf.enable = false;
      }
      (
        if display.enable then
          {
            wireless.iwd.enable = true;
          }
        else
          {
            useNetworkd = true;
          }
      )
    ];
    systemd.network = mkIf config.networking.useNetworkd {
      enable = true;
      wait-online.enable = lib.mkForce false;
    };
  };
}
