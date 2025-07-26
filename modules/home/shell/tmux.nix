{ osConfig, lib, ... }:
let
  cfg = osConfig.programs.tmux;
in
{
  config = lib.mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      mouse = true;
      newSession = true;
    };
  };
}
