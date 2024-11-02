{ inputs, pkgs, ... }:
{
  programs = {
    neovim = {
      enable = true;
      extraPackages = with pkgs; [
        gcc
        gnumake
        nodejs
        tree-sitter
      ];
    };
    wezterm.enable = true;
  };
  xdg.configFile = {
    nvim = {
      source = inputs.ggnvim;
      recursive = true;
    };
    wezterm = {
      source = inputs.ggterm;
      recursive = true;
    };
  };
}
