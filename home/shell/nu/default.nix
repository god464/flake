{
  imports = [ ../default.nix ];
  programs = {
    nushell.enable = true;
    zellij = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };
  };
}
