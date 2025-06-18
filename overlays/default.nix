{
  inputs,
  lib,
  self,
  ...
}:
{
  flake.overlays.default =
    _final: prev:
    lib.packagesFromDirectoryRecursive {
      callPackage = lib.callPackageWith (prev.pkgs // { inherit prev; });
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
