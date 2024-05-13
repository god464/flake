{ pkgs, ... }: {
  home = {
    username = "cl";
    homeDirectory = "/home/cl";
    stateVersion = "23.11";
  };
  imports = [ ./shell.nix ];
}
