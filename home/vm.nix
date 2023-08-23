{ sops, inputs, pkgs, config, lib, ... }:
{
  imports = [
    ./editor
    ./shell
    inputs.sops-nix.homeManagerModules.sops
  ];
  home = {
    username = "cl";
    homeDirectory = "/home/cl";
    packages = (with pkgs;[
      nil
      lua-language-server
      deadnix
      luaformatter
      nixpkgs-fmt
      pyright
      clang-tools
      coreutils
      black
      browsh
    ])
    ++ (with pkgs.luajitPackages; [
      luacheck
    ])
    ++ (with pkgs.python3Packages;[
      debugpy
    ]);
    stateVersion = "23.11";
  };
  programs.tmux = {
    enable = true;
    mouse = true;
  };
  sops = {
    age.keyFile = "/home/cl/.config/sops/age/keys.txt";
    defaultSopsFile = ./secrets.yaml;
  };
}
