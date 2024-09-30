{ inputs, pkgs, ... }:
{
  home = {
    username = "cl";
    homeDirectory = "/home/cl";
    stateVersion = "24.05";
  };
  programs = {
    man.enable = false;
    bat = {
      enable = true;
      config.theme = "Nord";
      extraPackages = with pkgs.bat-extras; [
        batgrep
        batdiff
        batman
      ];
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
    fastfetch.enable = true;
    ripgrep.enable = true;
    zoxide.enable = true;
    fzf.enable = true;
    gpg.enable = true;
    htop.enable = true;
    fd.enable = true;
    eza = {
      enable = true;
      git = true;
      icons = true;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;
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
    ssh = {
      enable = true;
      addKeysToAgent = "yes";
      compression = true;
      hashKnownHosts = true;
    };
    neovim = {
      enable = true;
      extraPackages = with pkgs; [
        gcc
        gnumake
        nodejs
        tree-sitter
      ];
    };
    starship.enable = true;
  };
  services = {
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      pinentryPackage = pkgs.pinentry-gtk2;
    };
  };
  xdg.configFile.nvim = {
    source = inputs.ggnvim;
    recursive = true;
  };
}
