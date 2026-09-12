{ osConfig, lib, ... }:
let
  cfg = osConfig.programs.fish;
in
{
  config = lib.mkIf cfg.enable {
    programs.difftastic = {
      enable = true;
      git.enable = true;
      jujutsu.enable = true;
      git.mode = "both";
    };
  };
}
