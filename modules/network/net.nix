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
  options.network'.net = {
    name = mkOption { type = types.str; };
    allowTcpPorts = mkOption {
      type = types.listOf types.port;
      default = [ ];
    };
  };
  config = {
    networking = mkMerge [
      {
        hostName = cfg.name;
        nftables.enable = true;
        firewall = {
          enable = true;
          checkReversePath = "strict";
          filterForward = true;
          allowedTCPPorts = cfg.allowTcpPorts;
        };
      }
      (
        if display.enable then
          {
            networkmanager = {
              enable = true;
              enableStrongSwan = true;
            };
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
    services.resolved.enable = !display.enable;
  };
}
