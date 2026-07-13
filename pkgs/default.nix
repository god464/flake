{
  inputs,
  self,
  lib,
  ...
}:
let
  inherit (inputs) nixpkgs niri-flake llm-agents;

  mkPackageSet =
    scope:
    lib.packagesFromDirectoryRecursive {
      callPackage = lib.callPackageWith (
        scope
        // {
          inherit scope;
        }
      );
      directory = ./.;
    };
in
{
  flake.overlays.pkgs = _: prev: mkPackageSet prev;
  perSystem =
    { pkgs, system, ... }:
    {
      packages = mkPackageSet pkgs;
      _module.args.pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          checkMeta = true;
          warnUndeclaredOptions = true;
        };
        overlays = [
          self.overlays.pkgs
          niri-flake.overlays.niri
          llm-agents.overlays.shared-nixpkgs
        ];
      };
    };
}
