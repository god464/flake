{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.services'.ssh;
in
{
  config = mkIf cfg.enable {
    services.fail2ban = {
      enable = true;
      bantime-increment.enable = true;
    };
  };
}
