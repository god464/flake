{ lib, config, ... }:
let
  inherit (lib) mkOption types mkIf;
  cfg = config.network'.net;
  hasDisplay = config.services.displayManager.enable;
in
{
  options.network'.net.name = mkOption { type = types.str; };
  config = {
    services.resolved.enable = true;
    networking = {
      hostName = cfg.name;
      nftables.enable = true;
      firewall = {
        enable = true;
        checkReversePath = "strict";
        filterForward = true;
      };
      networkmanager = mkIf hasDisplay {
        enable = true;
        ethernet.macAddress = "random";
        wifi.macAddress = "random";
        wifi.backend = "iwd";
        dns = "systemd-resolved";
      };
      useNetworkd = !hasDisplay;
    };
    systemd.network = mkIf config.networking.useNetworkd {
      enable = true;
      wait-online.enable = lib.mkForce false;
    };
  };
}
