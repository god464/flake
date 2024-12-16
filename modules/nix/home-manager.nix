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
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  options.nix'.home-manager.enable = mkEnableOption "home-manager";
  config = mkIf cfg.enable {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      sharedModules = [ inputs.plasma-manager.homeManagerModules.plasma-manager ];
      users.cl = {
        home.stateVersion = "24.11";
        programs = {
          plasma = {
            enable = true;
            input.touchpads = [
              {
                naturalScroll = true;
                tapToClick = true;
                vendorId = "06CB";
                productId = "CD50";
                name = "SYNA32AC:00 06CB:CD50 Touchpad";
              }
            ];
          };
          wezterm.enable = true;
          atuin.enable = true;
          bat = {
            enable = true;
            config.theme = "Nord";
            extraPackages = with pkgs.bat-extras; [
              batgrep
              batdiff
              batman
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
          fzf.enable = true;
          htop.enable = true;
          ripgrep.enable = true;
          zoxide.enable = true;
          neovim = {
            enable = true;
            extraPackages = with pkgs; [
              luarocks
              nodejs
              luajit
              tree-sitter
              gh
            ];
          };
          git = {
            enable = true;
            delta.enable = true;
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
              man = "batman";
              diff = "batdiff";
              rg = "batgrep";
            };
          };
          starship = {
            enable = true;
            settings = {
              c.symbol = "󰙱 ";
              cmake.symbol = "";
              java.symbol = "";
              lua.symbol = "󰢱 ";
              nix_shell.symbol = "󱄅 ";
              package.symbol = " ";
              python.symbol = " ";
              rust.symbol = " ";
              directory = {
                read_only = "";
                home_symbol = "";
                substitutions = {
                  Documents = "󰈙 ";
                  Downloads = " ";
                  Music = " ";
                  Pictures = " ";
                  Videos = " ";
                  Desktop = " ";
                };
              };
              git_branch.symbol = " ";
              git_commit.tag_symbol = "  ";
              git_status = {
                conflicted = "󰇼";
                ahead = "󰁝";
                behind = "󰁅";
                diverged = "󰹹";
                untracked = "";
                stashed = "";
                modified = "";
                staged = "";
                renamed = "";
                deleted = "";
              };
              jobs.symbol = "󰫢";
            };
          };
          gpg.enable = true;
          ssh = {
            enable = true;
            forwardAgent = true;
            addKeysToAgent = "yes";
          };
        };
        xdg.configFile = {
          wezterm = {
            source = inputs.ggterm;
            recursive = true;
          };
          nvim = {
            source = inputs.ggnvim;
            recursive = true;
          };
        };
      };
    };
  };
}
