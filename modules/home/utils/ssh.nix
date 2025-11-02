{
  config = {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks = {
        "*" = {
          addKeysToAgent = "yes";
          compression = true;
          hashKnownHosts = true;
        };
        "github.com" = {
          hostname = "github.com";
          user = "git";
          identityFile = "~/.ssh/id_ed25519";
        };
        "github_work" = {
          hostname = "github.com";
          user = "git";
          identityFile = "~/.ssh/github_work";
        };
      };
    };
  };
}
