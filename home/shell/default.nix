{ pkgs, config, lib, ... }:
{
  programs = {
    zsh = {
      enable = true;
      history = {
        size = 10000;
      };
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "git-extras" "gitignore" "extract" "zoxide" "fzf" "ripgrep" ];
        theme = "gentoo";
      };
      shellAliases = {
        cat = "bat";
        cd = "z";
        cp = "rsync";
        find = "fd";
        grep = "rg";
        sed = "sd";
      };
    };
    ssh = {
      enable = true;
      compression = true;
      hashKnownHosts = true;
    };
    gpg = {
      enable = true;
    };
    lazygit = {
      enable = true;
    };
    git = {
      enable = true;
    };
    ripgrep = {
      enable = true;
      arguments = [
        "--max-columns-preview"
        "--colors=line:style:bold"
      ];
    };
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras;[
        prettybat
        batwatch
        batpipe
        batman
        batgrep
        batdiff
      ];
    };
    exa = {
      enable = true;
      enableAliases = true;
      git = true;
      icons = true;
    };
    zoxide = {
      enable = true;
    };
    fzf = {
      enable = true;
    };
  };
  home.packages = lib.mkAfter (with pkgs;[
    sd
    rsync
  ]);
  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps.enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
