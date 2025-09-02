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
        luarocks
        clang
        gnumake
        nodejs_latest
        node-gyp
        luajit
      ];
    };
    xdg.configFile.nvim = {
      source = inputs.ggnvim;
      recursive = true;
    };
  };
}
