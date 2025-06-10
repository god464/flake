{ osConfig, lib, ... }:
let
  cfg = osConfig.programs.fish;
in
{
  config = lib.mkIf cfg.enable {
    programs.fzf = {
      enable = true;
      defaultCommand = "fd –type f –follow –exclude .git";
    };
  };
}
