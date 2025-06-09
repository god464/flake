{
  config = {
    programs.ssh = {
      enable = true;
      addKeysToAgent = "yes";
      compression = true;
      hashKnownHosts = true;
      extraConfig = ''
        Host github.com
          HostName github.com
          User git
          IdentityFile ~/.ssh/id_ed25519

        Host github-work
          HostName github.com
          User git
          IdentityFile ~/.ssh/github_work
      '';
    };
  };
}
