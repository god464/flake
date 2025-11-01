{
  inputs,
  osConfig,
  lib,
  pkgs,
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
      extraPackages = with pkgs; [
        clang
        copilot-language-server
      ];
    };
    xdg.configFile.nvim = {
      source = inputs.ggnvim;
      recursive = true;
    };
  };
}
