{ config, lib, ... }:
with lib;
let
  cfg = config.net;
in
{
  options.net = {
    enable = mkEnableOption "net";
    name = mkOption { type = types.str; };
  };
  config = mkIf cfg.enable {
    services = mkMerge [
      {
        openssh = {
          settings.PermitRootLogin = "no";
          openFirewall = false;
        };
      }
      (mkIf (config.networking.useNetworkd) { resolved.enable = true; })
    ];
    networking = mkMerge [
      {
        hostName = cfg.name;
        nftables.enable = true;
        firewall = {
          enable = true;
          checkReversePath = "strict";
          filterForward = true;
        };
      }
      (mkIf config.services.displayManager.sddm.enable {
        networkmanager = {
          enable = true;
          wifi.backend = "iwd";
          enableStrongSwan = true;
        };
      })
      (mkIf (!config.services.displayManager.sddm.enable) { useNetworkd = true; })
    ];

    systemd.network = mkIf config.networking.useNetworkd {
      enable = true;
      wait-online.enable = lib.mkForce false;
    };
  };
}
