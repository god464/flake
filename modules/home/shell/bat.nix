{
  pkgs,
  osConfig,
  lib,
  ...
}:
let
  cfg = osConfig.programs.fish;
in
{
  config = lib.mkIf cfg.enable {
    programs.bat = {
      enable = true;
      config.theme = lib.mkForce "Nord";
      extraPackages = with pkgs.bat-extras; [
        batpipe
        batgrep
        batdiff
      ];
    };
  };
}
