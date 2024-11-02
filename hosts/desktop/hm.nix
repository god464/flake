{ inputs, pkgs, ... }:
{
  programs = {
    man.enable = false;
    fastfetch.enable = true;
    gpg.enable = true;
    htop.enable = true;
    neovim = {
      enable = true;
      extraPackages = with pkgs; [
        gcc
        gnumake
        nodejs
        tree-sitter
      ];
    };
    wezterm.enable = true;
  };
  services = {
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      pinentryPackage = pkgs.pinentry-gtk2;
    };
  };
  xdg.configFile = {
    nvim = {
      source = inputs.ggnvim;
      recursive = true;
    };
    wezterm = {
      source = inputs.ggterm;
      recursive = true;
    };
  };
}
