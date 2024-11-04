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
        package.symbol = " ";
        python.symbol = " ";
        rust.symbol = " ";
        directory = {
          read_only = "";
          home_symbol = "";
        };
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
        jobs.symbol = "󰫢";
      };
    };
  };
}
