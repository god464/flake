{ config, lib, ... }:
let
  cfg = config.programs'.fish;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.programs'.fish.enable = mkEnableOption "fish";
  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;
      useBabelfish = true;
    };
    home-manager.users.cl.programs.fish = {
      enable = true;
      shellAbbrs = {
        ls = "eza";
        cd = "z";
        cat = "bat";
        man = "batman";
        diff = "batdiff";
        rg = "batgrep";
      };
    };
    environment.persistence."/persist".users.cl.directories = [ ".local/share/fish" ];
  };
}
