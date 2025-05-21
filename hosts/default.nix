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
                nixos-facter-modules.nixosModules.facter
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
        laptop = mkNixossystem "laptop";
        server = mkNixossystem "server";
        # iso = mkNixossystem "iso";
      };
    };
}
