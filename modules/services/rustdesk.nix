{ config, lib, ... }:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.services'.rustdesk;
in
{
  options.services'.rustdesk.enable = mkEnableOption "rustdesk";
  config = mkIf cfg.enable {
    services.rustdesk-server = {
      enable = true;
      openFirewall = true;
      signal.relayHosts = [ "localhost" ];
    };
  };
}
