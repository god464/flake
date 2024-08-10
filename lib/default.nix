#TODO
{ lib, inputs, ... }:
{
  mkDesktopHost =
    host:
    lib.nixosSystem {
      modules = [
        inputs.home-manager.nixosModules.home-manager
        inputs.disko.nixosModules.disko
        inputs.sops-nix.nixosModules.sops
        inputs.nixos-cosmic.nixosModules.default
        ../disko/desktop.nix
        ../modules
        ./host/${host}
      ];
    };
  mkServerHost =
    host:
    lib.nixosSystem {
      modules = [
        inputs.disko.nixosModules.disko
        inputs.sops-nix.nixosModules.sops
        inputs.nixos-cosmic.nixosModules.default
        ../disko/server.nix
        ../modules
        ./host/${host}
      ];
    };
}
