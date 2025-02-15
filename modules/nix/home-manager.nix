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
        fonts.fontconfig.enable = true;
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
          # wezterm.enable = true;
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
          ghostty = {
            enable = true;
            enableFishIntegration = true;
            settings = {
              theme = "nightfox";
              font-family = "Fira Code";
              background-opacity = 0.7;
              font-feature = [
                "cv01"
                "cv02"
                "cv14"
                "cv30"
                "ss01"
                "ss02"
                "ss03"
                "ss05"
                "ss07"
                "zero"
              ];
            };
          };
        };
        xdg.configFile = {
          /*
            wezterm = {
              source = inputs.ggterm;
              recursive = true;
            };
          */
          nvim = {
            source = inputs.ggnvim;
            recursive = true;
          };
        };
      };
    };
  };
}
