{ inputs, pkgs, config, lib, ... }:
{
  imports = [
    ./editor
    ./desktop
    inputs.nur.nixosModules.nur
  ];
  home = {
    username = "cl";
    homeDirectory = "/home/cl";
    packages = with pkgs;[
      nil
      lua-language-server
      deadnix
      luajitPackages.luacheck
      luaformatter
      nixpkgs-fmt
      pyright
      clang-tools
      nerdfonts
      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      font-awesome
      source-sans
      source-serif
      source-han-sans
      source-han-serif
      swww
      hyprpicker
      cliphist
      udiskie
      telegram-desktop
      wl-clipboard
      coreutils
    ];
  };
  programs = {
    firefox.enable = true;
    thunderbird.enable = true;
    zathura.enable = true;
  };
}
