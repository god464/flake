{ config, lib, ... }:
let
  cfg = config.web'.app.ntfy;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.web'.app.ntfy.enable = mkEnableOption "ntfy";
  config = mkIf cfg.enable {
    services.ntfy-sh = {
      enable = true;
    };
  };
}
