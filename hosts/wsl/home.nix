{
  imports = [ ../../home/shell/zsh ../../home/editor ];
  home = {
    username = "nixos";
    homeDirectory = "/home/nixos";
    stateVersion = "23.11";
  };
  programs.tmux = {
    enable = true;
    mouse = true;
    aggressiveResize = true;
  };
}
