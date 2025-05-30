{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.dns'.bind;
in
{
  options.dns'.bind.enable = mkEnableOption "Bind";
  config = mkIf cfg.enable {
    services.bind = {
      enable = true;
    };
  };
}
