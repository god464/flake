{
  programs = {
    ssh = {
      enable = true;
      compression = true;
      hashKnownHosts = true;
    };
    gpg = { enable = true; };
    lazygit = { enable = true; };
    git = {
      enable = true;
      lfs.enable = true;
      delta.enable = true;
    };
    ripgrep = {
      enable = true;
      arguments = [ "--max-columns-preview" "--colors=line:style:bold" ];
    };
    zoxide.enable = true;
    fzf.enable = true;
  };
  services = {
    gpg-agent = {
      enable = true;
      enableExtraSocket = true;
      enableSshSupport = true;
    };
  };
}
