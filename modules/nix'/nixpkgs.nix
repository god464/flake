{
  nixpkgs = {
    config = {
      allowUnfree = true;
      checkMeta = true;
      warnUndeclaredOptions = true;
    };
    hostPlatform = "x86_64-linux";
  };
  system.stateVersion = "24.11";
}
