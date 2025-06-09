{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.fish;
  inherit (lib) mkIf;
in
{
  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      extraPackages = with pkgs; [
        clang
        luarocks
        lua
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
