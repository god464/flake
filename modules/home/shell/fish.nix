{
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  cfg = osConfig.programs.fish;
in
{
  config = lib.mkIf cfg.enable {
    programs.fish = {
      enable = true;
      shellAbbrs = {
        ls = "eza";
        cd = "z";
        cat = "bat";
        diff = "batdiff";
        less = "batpipe";
        rg = "batgrep";
        man = "batman";
      };
      plugins = [
        {
          name = "autopair";
          src = pkgs.fishPlugins.autopair;
        }
      ];
    };
  };
}
