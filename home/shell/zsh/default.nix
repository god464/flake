{ pkgs, lib, ... }: {
  imports = [ ../default.nix ];
  programs = {
    zsh = {
      enable = true;
      history.size = 10000;
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
      historySubstringSearch.enable = true;
      oh-my-zsh = {
        enable = true;
        plugins =
          [ "git" "git-extras" "gitignore" "extract" "zoxide" "fzf" "ripgrep" ];
        theme = "gentoo";
      };
      shellAliases = {
        cat = "bat";
        cd = "z";
      };
    };
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        prettybat
        batwatch
        batpipe
        batman
        batgrep
        batdiff
      ];
    };
    eza = {
      enable = true;
      enableAliases = true;
      git = true;
      icons = true;
    };
    git = {
      enable = true;
      delta.enable = true;
      lfs.enable = true;
    };
  };
  home.packages = lib.mkAfter (with pkgs; [ sd rsync ]);
}
