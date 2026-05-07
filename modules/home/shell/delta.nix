{ osConfig, lib, ... }:
let
  cfg = osConfig.programs.fish;
in
{
  config = lib.mkIf cfg.enable {
    programs.delta = {
      enable = true;
      enableGitIntegration = true;
      enableJujutsuIntegration = true;
      options = {
        dark = true;
        line-numbers = true;
      };
    };
  };
}
