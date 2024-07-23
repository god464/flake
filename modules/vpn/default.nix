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
  config = {
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
                PresharedKeyFile = config.sops.secrets.wg-ser2bul.path;
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

    # TODO
    networking.networkmanager.settings =
      (mkIf cfg.client.enable && config.services.displayManager.sddm.enable)
        {
          connection = {
            id = "wg0";
            type = "wireguard";
            interface-name = "wg0";
          };
          wireguard = {
            listen-port = 51820;
          };
          wireguard-peer = { };
        };
  };
}
