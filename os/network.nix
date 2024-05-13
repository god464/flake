{ lib, ... }: {
  networking = {
    hostName = "nixos";
    nftables.enable = true;
    useNetworkd = true;
    firewall = {
      enable = true;
      filterForward = true;
    };
  };
  systemd.network.wait-online.enable = lib.mkForce false;
}
