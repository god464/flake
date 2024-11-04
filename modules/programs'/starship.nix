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
        c.symbol = "󰙱 ";
        lua.symbol = "󰢱 ";
        nix_shell.symbol = "󱄅 ";
        python.symbol = " ";
        rust.symbol = " ";
        git_branch.symbol = " ";
        git_status = {
          conflicted = "󰇼";
          ahead = "󰁝";
          behind = "󰁅";
          diverged = "󰹹";
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
