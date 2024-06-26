{ pkgs, ... }:
{
  home = {
    username = "cl";
    homeDirectory = "/home/cl";
    stateVersion = "24.05";
  };
  programs = {
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      historySubstringSearch.enable = true;
      plugins = [
        {
          name = "powerlevel10k-config";
          src = ./p10k;
          file = "p10k.zsh";
        }
        {
          name = "zsh-powerlevel10k";
          src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
          file = "powerlevel10k.zsh-theme";
        }
      ];
      initExtraFirst = ''
        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi
      '';

      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "gitignore"
          "extract"
          "zoxide"
          "fzf"
          "ripgrep"
        ];
      };
      shellAliases = {
        cat = "bat";
        cd = "z";
        rg = "batgrep";
        diff = "batdiff";
        man = "batman";
      };
    };
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        batgrep
        batdiff
        batman
      ];
    };
    eza = {
      enable = true;
      git = true;
      icons = true;
    };
    fastfetch.enable = true;
    ripgrep.enable = true;
    fzf.enable = true;
    gpg.enable = true;
    zoxide.enable = true;
    htop.enable = true;
    fd.enable = true;
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
    ssh = {
      enable = true;
      addKeysToAgent = "yes";
      compression = true;
      hashKnownHosts = true;
    };
    neovim = {
      enable = true;
      # plugins = with pkgs.vimPlugins; [
      #   {
      #     plugins = nvim-cmp;
      #     type = "lua";
      #   }
      # ];
      extraLuaConfig = builtins.readFile ./init.lua;
    };
  };
  services = {
    gpg-agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-all;
    };
    ssh-agent.enable = true;
  };
}
