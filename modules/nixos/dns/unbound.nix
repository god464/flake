{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.dns'.unbound;
in
{
  options.dns'.unbound.enable = mkEnableOption "Bind";
  config = mkIf cfg.enable {
    services.unbound = {
      enable = true;
    };
  };
}
