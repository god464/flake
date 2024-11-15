{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs'.fish;
  inherit (lib) mkIf;
in
{
  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      vimAlias = true;
      viAlias = true;
      withNodeJs = true;
      withPython3 = true;
      defaultEditor = true;
    };
    home-manager.users.cl = {
      programs.neovim = {
        enable = true;
        extraPackages = with pkgs; [
          clang
          gnumake
          nodejs
          luarocks
          tree-sitter
        ];
      };
      xdg.configFile.nvim = {
        source = inputs.ggnvim;
        recursive = true;
      };
    };
    environment.persistence."/persist".users.cl.directories = [
      ".local/share/nvim"
      ".cache/nvim"
    ];
  };
}
