{
  imports = [ ../../home/shell/zsh ../../home/editor ];
  home = {
    username = "cl";
    homeDirectory = "/home/cl";
    stateVersion = "23.11";
  };
  programs.tmux = {
    enable = true;
    mouse = true;
    aggressiveResize = true;
  };
}
