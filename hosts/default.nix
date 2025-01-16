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
            specialArgs = { inherit inputs; };
            modules =
              with inputs;
              [
                disko.nixosModules.disko
                sops-nix.nixosModules.sops
                nixos-generators.nixosModules.all-formats
              ]
              ++ [
                ./${host}
                ../secrets
                self.nixosModules.default
              ];
          }
        );
      mkMicroVm =
        host:
        withSystem "x86_64-linux" (
          { lib, ... }:
          lib.nixosSystem {
            specialArgs = { inherit inputs; };
            modules =
              with inputs;
              [
                sops-nix.nixosModules.sops
                microvm.nixosModules.microvm
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
        desktop = mkNixossystem "desktop";
        server = mkNixossystem "server";
        vm-deploy = mkMicroVm "vm-deploy";
      };
    };
}
