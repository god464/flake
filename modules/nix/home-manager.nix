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
      users = {
        cl = {
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
            atuin.enable = true;
            bat = {
              enable = true;
              config.theme = "Nord";
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
              };
            };
            starship.enable = true;
            gpg.enable = true;
            ssh = {
              enable = true;
              forwardAgent = true;
              addKeysToAgent = "yes";
            };
            kitty = {
              enable = true;
              font = {
                package = pkgs.iosevka.override {
                  set = "Custom";
                  privateBuildPlan = {
                    family = "Iosevka Custom";
                    spaceing = "term";
                    serifs = "sans";
                    noCvSs = true;
                    exportGlyphNames = true;
                    variants = {
                      inherits = "ss05";
                      design = {
                        capital-q = "crossing";
                        a = "single-storey-top-cut-serifed";
                        g = "single-storey-serifless";
                      };
                    };
                  };
                };
                name = "Iosevka Custom";
                size = 13.0;
              };
              themeFile = "gruvbox-dark-hard";
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
        elysium = {
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
            atuin.enable = true;
            bat = {
              enable = true;
              config.theme = "Nord";
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
            ripgrep.enable = true;
            zoxide.enable = true;
            fish = {
              enable = true;
              shellAbbrs = {
                ls = "eza";
                cd = "z";
                cat = "bat";
              };
            };
            starship.enable = true;
            gpg.enable = true;
            ssh = {
              enable = true;
              forwardAgent = true;
              addKeysToAgent = "yes";
            };
            ghostty = {
              enable = true;
            };
            zed-editor = {
              enable = true;
            };
          };
        };
      };
    };
  };
}
