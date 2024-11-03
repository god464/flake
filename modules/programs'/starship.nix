{ config, lib, ... }:
let

  cfg = config.programs'.fish;
  inherit (lib) mkIf;
in
{
  config = mkIf cfg.enable {
    home-manager.users.cl.programs.starship = {
      enable = true;
      settings = {
        git_branch.symbol = " ";
        git_state = {
          conflicted = "";
          ahead = "";
          behind = "";
          diverged = "";
          untracked = "";
          stashed = "";
          modified = "";
          staged = "";
          renamed = "";
          deleted = "";
        };
      };
    };
  };
}
