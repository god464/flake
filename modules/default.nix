{ lib, ... }:
let
  inherit (lib.filesystem) listFilesRecursive;
in
{
  flake = {
    nixosModules.default = {
      imports = listFilesRecursive ./nixos;
    };
    homeModules.default = {
      imports = listFilesRecursive ./home;
    };
  };
}
