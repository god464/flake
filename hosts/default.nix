{ inputs, ... }:
{
  flake =
    let
      inherit (inputs.nixpkgs) lib;
      mkNixossystem =
        host:
        lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };
          modules = [
            inputs.home-manager.nixosModules.home-manager
            inputs.disko.nixosModules.disko
            inputs.sops-nix.nixosModules.sops
            inputs.nixos-cosmic.nixosModules.default
            inputs.impermanence.nixosModules.impermanence
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
