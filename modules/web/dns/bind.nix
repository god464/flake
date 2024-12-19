{ config, lib, ... }:
let
  inherit (lib) mkEnableOption;
  cfg = config.web'.dns.bind;
in
{
  options.web'.dns.bind.enable = mkEnableOption "Bind";
  config = cfg.enable {
    services.bind = {
      enable = true;
    };
  };
}
