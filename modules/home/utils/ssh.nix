{
  config = {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings = {
        "*" = {
          AddKeysToAgent = "yes";
          Compression = true;
          HashKnownHosts = true;
        };
        "github.com" = {
          Hostname = "github.com";
          User = "git";
          IdentityFile = "~/.ssh/id_ed25519";
          IdentitiesOnly = true;
        };
        "github_work" = {
          Hostname = "github.com";
          User = "git";
          IdentityFile = "~/.ssh/github_work";
          IdentitiesOnly = true;
        };
      };
    };
  };
}
