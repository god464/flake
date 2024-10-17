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
          modules =
            with inputs;
            [
              home-manager.nixosModules.home-manager
              disko.nixosModules.disko
              sops-nix.nixosModules.sops
              nixos-cosmic.nixosModules.default
              impermanence.nixosModules.impermanence
            ]
            ++ [
              ./${host}
              ../modules
            ];
        };
    in
    {
      nixosConfigurations = {
        server = mkNixossystem "server";
        desktop = mkNixossystem "desktop";
      };
    };
}
