{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.web'.dns.unbound;
in
{
  options.web'.dns.unbound.enable = mkEnableOption "Bind";
  config = mkIf cfg.enable {
    services.unbound = {
      enable = true;
    };
  };
}
