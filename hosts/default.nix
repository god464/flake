{ inputs, withSystem, ... }:
{
  flake =
    let
      mkNixossystem =
        host:
        withSystem "x86_64-linux" (
          { lib, ... }:
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
                lanzaboote.nixosModules.lanzaboote
              ]
              ++ [
                ./${host}
                ../modules
              ];
          }
        );
    in
    {
      nixosConfigurations = {
        server = mkNixossystem "server";
        desktop = mkNixossystem "desktop";
      };
    };
}
