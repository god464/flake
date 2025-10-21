{
  inputs,
  self,
  lib,
  ...
}:
{
  flake.overlays.pkgs =
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
        config = {
          allowUnfree = true;
          checkMeta = true;
          warnUndeclaredOptions = true;
        };
        overlays = [
          self.overlays.pkgs
          inputs.niri-flake.overlays.niri
          inputs.nix-minecraft.overlay
        ];
      };
      legacyPackages = pkgs;
      packages.vm = self.nixosConfigurations.vm.config.microvm.declaredRunner;
    };
}
