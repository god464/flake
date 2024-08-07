{ pkgs, ... }:
{
  home = {
    username = "cl";
    homeDirectory = "/home/cl";
    stateVersion = "24.05";
  };
  programs = {
    nushell.enable = true;
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
      extraLuaConfig = builtins.readFile ./nvim.lua;
    };
    wezterm = {
      enable = true;
      extraConfig = builtins.readFile ./wezterm.lua;
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
