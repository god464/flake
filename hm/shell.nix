{ pkgs, config, ... }: {
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
        plugins = [ "git" "gitignore" "extract" "zoxide" "fzf" "ripgrep" ];
      };
      shellAliases = {
        cat = "bat";
        cd = "z";
        rg = "batgrep";
        diff = "batdiff";
      };
    };
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [ batgrep batdiff ];
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
  };
  services = {
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      pinentryPackage = pkgs.pinentry-all;
    };
  };
}
