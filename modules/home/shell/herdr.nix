{
  osConfig,
  lib,
  pkgs,
  ...
}:
let
  cfg = osConfig.programs.fish;
in
{
  config = lib.mkIf cfg.enable {
    programs.herdr = {
      enable = true;
      package = pkgs.llm-agents.herdr;
    };
  };
}
