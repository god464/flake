{ config, lib, ... }:
let
  cfg = config.programs'.tmux;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.programs'.tmux.enable = mkEnableOption "tmux";
  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      keyMode = "vi";
      clock24 = true;
      aggressiveResize = true;
    };
  };
}
