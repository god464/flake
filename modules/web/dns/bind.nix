{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.web'.dns.bind;
in
{
  options.web'.dns.bind.enable = mkEnableOption "Bind";
  config = mkIf cfg.enable {
    services.bind = {
      enable = true;
    };
  };
}
