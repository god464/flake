{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.nix'.home-manager;
  inherit (lib) mkIf mkEnableOption;
in
{
  imports = with inputs; [ home-manager.nixosModules.home-manager ];
  options.nix'.home-manager.enable = mkEnableOption "home-manager";
  config = mkIf cfg.enable {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.cl = {
        home.stateVersion = "25.05";
        programs = {
          atuin.enable = true;
          bat = {
            enable = true;
            config.theme = "Nord";
            extraPackages = with pkgs.bat-extras; [
              batpipe
              batgrep
              batdiff
            ];
          };
          direnv = {
            enable = true;
            nix-direnv.enable = true;
            silent = true;
          };
          eza = {
            enable = true;
            git = true;
            icons = "always";
          };
          fd.enable = true;
          fzf = {
            enable = true;
            defaultCommand = "fd –type f –follow –exclude .git";
          };
          htop.enable = true;
          ripgrep.enable = true;
          zoxide.enable = true;
          neovim = {
            enable = true;
            extraPackages = with pkgs; [
              clang
              luarocks
              lua
              nodejs
              tree-sitter
            ];
          };
          git = {
            enable = true;
            delta = {
              enable = true;
              options = {
                dark = true;
                line-numbers = true;
              };
            };
            userName = "god464";
            userEmail = "god464@users.noreply.github.com";
            signing = {
              key = "089E15607145FE932C002942D7A72706FC8DE569";
              signByDefault = true;
            };
          };
          fish = {
            enable = true;
            shellAbbrs = {
              ls = "eza";
              cd = "z";
              cat = "bat";
              diff = "batdiff";
              less = "batpipe";
              rg = "batgrep";
            };
          };
          starship.enable = true;
          gpg = {
            enable = true;
            mutableKeys = false;
            mutableTrust = false;
          };
          ssh = {
            enable = true;
            addKeysToAgent = "yes";
            compression = true;
            hashKnownHosts = true;
            extraConfig = ''
              Host github.com
                HostName github.com
                User git
                IdentityFile ~/.ssh/id_ed25519

              Host github-work
                HostName github.com
                User git
                IdentityFile ~/.ssh/github_work
            '';
          };
          kitty = {
            enable = true;
            font = {
              package = pkgs.maple-mono.Normal-CN;
              name = "Maple Mono Normal CN";
              size = 13.0;
            };
            themeFile = "everforest_dark_hard";
            settings = {
              copy_on_select = true;
              enabled_layouts = "Splits, Stack";
              enable_audio_bell = false;
              tab_bar_edge = "top";
              tab_bar_style = "powerline";
              tab_powerline_style = "round";
              background_opacity = 0.8;
              disable_ligatures = "cursor";
            };
          };
        };
        xdg.configFile.nvim = {
          source = inputs.ggnvim;
          recursive = true;
        };
      };
    };
  };
}
