{ config, lib, ... }:
let
  cfg = config.programs.fish;
  inherit (lib) mkIf;
in
{
  config = mkIf cfg.enable {
    programs.fzf = {
      enable = true;
      defaultCommand = "fd –type f –follow –exclude .git";
    };
  };
}
