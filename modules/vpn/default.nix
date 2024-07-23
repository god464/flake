{ config, lib, ... }:
with lib;
let
  cfg = config.vpn;
in
{
  options.vpn = mkOption {
    type =
      with types;
      submodule {
        options = {
          client.enable = mkEnableOption "wireguard client";
          server.enable = mkEnableOption "wireguad server";
        };
      };
  };
  config = cfg.enable {
    sops.secrets = mkMerge [
      (mkIf cfg.client.enable {
        sops.secrets = {
          wg-client = { };
          wg-preshaare = { };
        };
      })
      (mkIf cfg.server.enable {
        sops.secrets = {
          wg-server = { };
          wg-preshaare = { };
        };
      })
    ];
    systemd.network = mkMerge [
      (mkIf cfg.server.enable {
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
      (mkIf (cfg.client.enable && !config.displayManager.sddm.enable) {
        # TODO
      })
    ];
    networking.wg-quick.interfaces =
      (mkIf cfg.client.enable && config.services.displayManager.sddm.enable)
        {
          wg0 = {
            address = [ "192.168.50.3/24" ];
            PrivateKeyFile = config.sops.secrets.wg-client.path;
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
