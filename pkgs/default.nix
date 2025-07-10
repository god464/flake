{ inputs, self, ... }:
{
  flake.overlays.pkgs =
    _final: prev:
    prev.lib.packagesFromDirectoryRecursive {
      inherit (prev) callPackage;
      directory = ./.;
    };
  perSystem =
    { pkgs, system, ... }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          checkMeta = true;
          warnUndeclaredOptions = true;
        };
        overlays = [
          self.overlays.pkgs

          inputs.niri-flake.overlays.niri
        ];
      };
      legacyPackages = pkgs;
    };
}
