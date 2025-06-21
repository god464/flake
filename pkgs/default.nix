{ inputs, self, ... }:
{
  flake.overlays.default =
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
        overlays = [ self.overlays.default ];
      };
      legacyPackages = pkgs;
    };
}
