{ config, lib, ... }:
let

  cfg = config.programs'.fish;
  inherit (lib) mkIf;
in
{
  config = mkIf cfg.enable {
    home-manager.users.cl.programs.zoxide.enable = true;
    environment.persistence."/persist".users.cl.directories = [ ".local/share/zoxide" ];
  };
}
