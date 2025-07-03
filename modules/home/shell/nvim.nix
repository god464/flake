{
  inputs,
  pkgs,
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
      extraPackages = with pkgs; [
        clang
        luarocks
        lua5_1
        nodejs
        tree-sitter
      ];
    };
    xdg.configFile.nvim = {
      source = inputs.ggnvim;
      recursive = true;
    };
  };
}
