{ osConfig, lib, ... }:
let
  cfg = osConfig.programs.fish;
in
{
  config = lib.mkIf cfg.enable {
    programs.eza = {
      enable = true;
      git = true;
      icons = "always";
    };
  };
}
