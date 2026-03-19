{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.services'.ssh;
in
{
  config = mkIf cfg.enable {
    services.fail2ban = {
      enable = true;
      maxretry = 5;
      bantime-increment.enable = true;
    };
  };
}
