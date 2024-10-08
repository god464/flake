{ config, lib, ... }:
let
  inherit (lib)
    mkOption
    types
    mkMerge
    mkIf
    ;
  cfg = config.net;
  display = config.services.displayManager;
in
{
  options.net.name = mkOption { type = types.str; };
  config = {
    services = mkMerge [
      {
        openssh = {
          enable = true;
          startWhenNeeded = true;
        };
      }
      (mkIf display.enable {
        openssh = {
          settings.PermitRootLogin = "no";
          openFirewall = false;
        };
      })
      (mkIf config.networking.useNetworkd {
        resolved.enable = true;
        openssh.settings.PermitRootLogin = "yes";
        fail2ban = {
          enable = true;
          bantime-increment.enable = true;
        };
      })
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
      (mkIf display.enable {
        networkmanager = {
          enable = true;
          enableStrongSwan = true;
        };
      })
      (mkIf (!display.enable) { useNetworkd = true; })
    ];

    systemd.network = mkIf config.networking.useNetworkd {
      enable = true;
      wait-online.enable = lib.mkForce false;
    };
  };
}
