{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.dns'.bind;
in
{
  options.dns'.bind.enable = mkEnableOption "bind";
  config = mkIf cfg.enable {
    services.bind = {
      enable = true;
    };
  };
}
