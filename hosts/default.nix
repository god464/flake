{
  inputs,
  withSystem,
  self,
  ...
}:
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
                disko.nixosModules.disko
                sops-nix.nixosModules.sops
              ]
              ++ [
                ./${host}
                ../secrets
                self.nixosModules.default
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
