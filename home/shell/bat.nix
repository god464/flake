{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.fish;
  inherit (lib) mkIf;
in
{
  config = mkIf cfg.enable {
    programs.bat = {
      enable = true;
      config.theme = "Nord";
      extraPackages = with pkgs.bat-extras; [
        batpipe
        batgrep
        batdiff
      ];
    };
  };
}
