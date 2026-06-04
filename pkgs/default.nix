{
  inputs,
  self,
  lib,
  ...
}:
let
  inherit (inputs) nixpkgs niri-flake llm-agents;
in
{
  flake.overlays.pkgs =
    _: prev:
    lib.packagesFromDirectoryRecursive {
      callPackage = lib.callPackageWith (prev.pkgs // { inherit prev; });
      directory = ./.;
    };

  perSystem =
    { pkgs, system, ... }:
    {
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
          llm-agents.overlays.default
        ];
      };
      legacyPackages = pkgs;
    };
}
