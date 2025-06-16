{ lib, config, ... }:
let
  inherit (lib) mkOption types mkIf;
  cfg = config.network'.net;
  display = config.services.displayManager;
in
{
  options.network'.net.name = mkOption { type = types.str; };
  config = {
    networking = {
      hostName = cfg.name;
      nftables.enable = true;
      firewall = {
        enable = true;
        checkReversePath = "strict";
        filterForward = true;
      };
      useNetworkd = true;
      wireless = mkIf display.enable {
        enabled = true;
        iwd = {
          enable = true;
          settings.general.AddressRandomization = "network";
        };
      };
    };
    systemd.network = {
      enable = true;
      wait-online.enable = false;
    };
    services.resolved = {
      enable = !display.enable;
      dnssec = "true";
    };
  };
}
