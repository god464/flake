{ inputs, ... }:
{
  flake =
    let
      lib = inputs.nixpkgs.lib;
      mkNixossystem =
        host:
        lib.nixosSystem {
          modules = [
            inputs.home-manager.nixosModules.home-manager
            inputs.disko.nixosModules.disko
            inputs.sops-nix.nixosModules.sops
            inputs.nixos-cosmic.nixosModules.default
            ../disko/desktop.nix
            ./${host}
            ../modules
          ];
        };
    in
    {
      nixosConfigurations = {
        router = mkNixossystem "router";
        builder = mkNixossystem "builder";
      };
    };
}
