{ inputs, pkgs, ... }:
{
  config = {
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
