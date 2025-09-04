{
  inputs,
  osConfig,
  lib,
  ...
}:
let
  cfg = osConfig.programs.neovim;
in
{
  config = lib.mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      withNodeJs = true;
      withPython3 = true;
      withRuby = true;
    };
    xdg.configFile.nvim = {
      source = inputs.ggnvim;
      recursive = true;
    };
  };
}
