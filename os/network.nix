{ lib, config, ... }: {
  networking = {
    hostName = "nixos";
    nftables.enable = true;
    useNetworkd = true;
    firewall = {
      enable = true;
      checkReversePath = "strict";
      filterForward = true;
      allowedUDPPorts = [ 51820 ];
    };
  };
  systemd.network = {
    enable = true;
    wait-online.enable = lib.mkForce false;
    netdevs = {
      "50-wg0" = {
        enable = true;
        netdevConfig = {
          Kind = "wireguard";
          Name = "wg0";
        };
        wireguardConfig = {
          PrivateKeyFile = config.sops.secrets.wgkey.path;
          ListenPort = 51820;
        };
        wireguardPeers = [{
          PublicKey = "gdDHymLRORl7K5LskRdGN5yIbdSWQcVfYKyygszZ220=";
          AllowedIPs = [ "192.168.20.1" ];
          PersistentKeepalive = 20;
        }];
      };
    };
    networks.wg0 = {
      enable=true;
      matchConfig.Name = "wg0";
      address = [ "192.168.50.1/24" ];
      networkConfig = {
        IPMasquerade = "ipv4";
        IPForward = true;
      };
    };
  };
}
