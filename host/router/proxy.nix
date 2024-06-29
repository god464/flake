{ config, ... }: {
  systemd.network = {
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
