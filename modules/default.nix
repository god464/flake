{ lib, ... }:
let
  importModules' =
    dir:
    lib.filter (path: lib.hasSuffix ".nix" (builtins.baseNameOf path)) (
      lib.filesystem.listFilesRecursive dir
    );
in
{
  flake = {
    nixosModules.default = {
      imports = importModules' ./nixos;
    };
    homeModules.default = {
      imports = importModules' ./home;
    };
  };
}
