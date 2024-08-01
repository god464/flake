{ config, lib, ... }:
let
  inherit (lib)
    types
    mkOption
    mkEnableOption
    mkMerge
    mkIf
    ;
  cfg = config.vpn;
in
{
  options.vpn = {
    enable = mkEnableOption "vpn";
    role = mkOption {
      type = types.enum [
        "server"
        "client"
      ];
    };
  };
  config = mkIf cfg.enable {
    sops.secrets = mkMerge [
      (mkIf (cfg.role == "client") {
        wg-client = { };
        wg-preshare = { };
      })
      (mkIf (cfg.role == "server") {
        wg-server = { };
        wg-preshare = { };
      })
    ];
    systemd.network = mkMerge [
      (mkIf (cfg.role == "server") {
        netdevs = {
          "50-wg0" = {
            enable = true;
            netdevConfig = {
              Kind = "wireguard";
              Name = "wg0";
            };
            wireguardConfig = {
              PrivateKeyFile = config.sops.secrets.wg-server.path;
              ListenPort = 51820;
            };
            wireguardPeers = [
              {
                PublicKey = "b3xxDApNqwMWAW1D3zLKtvDr7ONvRWfveAP1oTsg+lQ=";
                AllowedIPs = [ "192.168.50.0/24" ];
                PersistentKeepalive = 20;
                PresharedKeyFile = config.sops.secrets.wg-preshare.path;
              }
            ];
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
      })
      (mkIf ((cfg.role == "client") && (!config.services.displayManager.sddm.enable)) {
        netdevs = {
          "10-wg0" = {
            enable = true;
            netdevConfig = {
              Kind = "wireguard";
              Name = "wg0";
            };
            wireguardConfig = {
              PrivateKeyFile = config.sops.secrets.wg-client.path;
              ListenPort = 51820;
            };
            wireguardPeers = [
              {
                PublicKey = "b3xxDApNqwMWAW1D3zLKtvDr7ONvRWfveAP1oTsg+lQ=";
                AllowedIPs = [ "192.168.50.0/24" ];
                PersistentKeepalive = 20;
                PresharedKeyFile = config.sops.secrets.wg-preshare.path;
                EndPoint = "192.168.50.1:51820";
              }
            ];
          };
        };
      })
    ];
    networking.wg-quick.interfaces =
      mkIf ((cfg.role == "client") && config.services.displayManager.sddm.enable)
        {
          wg0 = {
            address = [ "192.168.50.3/24" ];
            privateKeyFile = config.sops.secrets.wg-client.path;
            peers = [
              {
                publicKey = "kR8ZxNd/1DkKgb3TN7t5McJpRklYLViAkvY96iNnri8=";
                allowedIPs = [ "192.168.50.0/24" ];
                persistentKeepalive = 20;
                presharedKeyFile = config.sops.secrets.wg-preshare.path;
              }
            ];
          };
        };
  };
}
