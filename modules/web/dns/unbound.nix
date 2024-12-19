{ config, lib, ... }:
let
  inherit (lib) mkEnableOption;
  cfg = config.web'.dns.unbound;
in
{
  options.web'.dns.unbound.enable = mkEnableOption "Bind";
  config = cfg.enable {
    services.unbound = {
      enable = true;
    };
  };
}
