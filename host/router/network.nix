{ lib, ... }:
{
  networking = {
    hostName = "router";
    nftables.enable = true;
    useNetworkd = true;
    firewall = {
      enable = true;
      checkReversePath = "strict";
      filterForward = true;
      allowedUDPPorts = [ 51820 ];
      interfaces.wg0.allowedTCPPorts = [ 22 ];
    };
  };
  systemd.network = {
    enable = true;
    wait-online.enable = lib.mkForce false;
  };
  services.resolved.enable = true;
}
