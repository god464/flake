{
  config,
  lib,
  pkgs,
  ...
}:
let

  cfg = config.programs'.fish;
  inherit (lib) mkIf;
in
{
  config = mkIf cfg.enable {
    home-manager.users.cl.programs.bat = {
      enable = true;
      config.theme = "Nord";
      extraPackages = with pkgs.bat-extras; [
        batgrep
        batdiff
        batman
      ];
    };
    environment.persistence."/persist".users.cl.directories = [ ".cache/bat" ];
  };
}
