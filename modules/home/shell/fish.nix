{ config, lib, ... }:
let
  cfg = config.programs.fish;
  inherit (lib) mkIf;
in
{
  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;
      shellAbbrs = {
        ls = "eza";
        cd = "z";
        cat = "bat";
        diff = "batdiff";
        less = "batpipe";
        rg = "batgrep";
      };
    };
  };
}
