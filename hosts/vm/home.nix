{ pkgs, inputs, ... }: {
  imports = [ ../../home/shell/zsh ../../home/editor ../../home ];
  home = { packages = (with pkgs; [ coreutils nix-init ]); };
  programs.tmux = {
    enable = true;
    mouse = true;
    aggressiveResize = true;
  };
}
