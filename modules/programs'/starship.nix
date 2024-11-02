{ config, lib, ... }:
let

  cfg = config.programs'.fish;
  inherit (lib) mkIf;
in
{
  config = mkIf cfg.enable {
    home-manager.users.cl.programs.starship = {
      enable = true;
      enableTransience = true;
    };
  };
}
