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
      interfaces.wg0.allowedTCPPorts = [ 22 ];
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
          PublicKey = "22VmKbaYM/fXiXwYesmNlrbGitE8QD8o0K9ROaA1jUM=";
          AllowedIPs = [ "192.168.50.0/24" ];
          PersistentKeepalive = 20;
        }];
      };
    };
    networks.wg0 = {
      enable = true;
      matchConfig.Name = "wg0";
      address = [ "192.168.50.1/24" ];
      networkConfig = {
        IPMasquerade = "both";
        IPv4ProxyARP = "yes";
      };
    };
  };
}
