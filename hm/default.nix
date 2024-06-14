{ pkgs, ... }: {
  home = {
    username = "cl";
    homeDirectory = "/home/cl";
    stateVersion = "24.05";
  };
  imports = [ ./shell.nix ];
}
