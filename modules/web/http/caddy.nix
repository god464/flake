{ config, lib, ... }:
let
  cfg = config.web'.http.caddy;
  inherit (lib) mkOption mkEnableOption types;
in
{
  options.web'.http.caddy = {
    enable = mkEnableOption "caddy";
    name = lib.mkOption {
      type = types.str;
      default = "localhost";
    };
    address = mkOption {
      type = types.listOf types.str;
      default = [
        "127.0.0.1"
        "::1"
      ];
    };
    aliases = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };
    config = mkOption {
      type = types.lines;
      default = "";
    };
  };
  config = lib.mkIf cfg.enable {
    services.caddy = {
      enable = true;
      virtualHosts."${cfg.name}" = {
        listenAddresses = cfg.address;
        serverAliases = cfg.aliases;
        extraConfig = cfg.config;
      };
    };
  };
}
