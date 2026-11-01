{ osConfig, lib, ... }:
let
  cfg = osConfig.programs.fish;
in
{
  config = lib.mkIf cfg.enable {
    programs = {
      yazi.enable = true;
      zoxide.enable = true;
      starship.enable = true;
      ripgrep.enable = true;
      fd.enable = true;
      bottom.enable = true;
    };
  };
}
