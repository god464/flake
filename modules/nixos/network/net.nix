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
          checkReversePath = "strict";
          filterForward = true;
        };
      }
      (
        if display.enable then
          {
            networkmanager = {
              enable = true;
              ethernet.macAddress = "random";
              wifi.macAddress = "ramdom";
              wifi.backend = "iwd";
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
    services.resolved = {
      enable = !display.enable;
      dnssec = "allow-downgrade";
      dnsovertls = "opportunistic";
    };
  };
}
