{ config, lib, ... }:
let
  cfg = config.programs'.fish;
  inherit (lib) mkIf;
in
{
  config = mkIf cfg.enable {
    home-manager.users.cl.programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;
    };
    environment.persistence."/persist".users.cl.directories = [ ".local/share/direnv" ];
  };
}
