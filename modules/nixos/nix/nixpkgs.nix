{ inputs, ... }:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      checkMeta = true;
      warnUndeclaredOptions = true;
    };
    hostPlatform = "x86_64-linux";
    overlays = [ inputs.niri-flake.overlays.niri ];
  };
  system.stateVersion = "25.05";
}
