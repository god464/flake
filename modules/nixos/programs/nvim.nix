{ config, lib, ... }:
let
  cfg = config.programs.fish;
  inherit (lib) mkIf;
in
{
  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      vimAlias = true;
      viAlias = true;
      defaultEditor = true;
    };
  };
}
