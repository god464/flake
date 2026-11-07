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
        luarocks
        tree-sitter
      ];
    };
    home.packages =
      with pkgs;
      [
        lsof
        sqlit-tui
      ]
      ++ (with pkgs.llm-agents; [
        omp
        copilot-language-server
      ]);

    xdg.configFile.nvim = {
      source = inputs.ggnvim;
      recursive = true;
    };
  };
}
