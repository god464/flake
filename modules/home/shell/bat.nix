{ config, pkgs, ... }:
{
  config = {
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
