{
  inputs,
  withSystem,
  self,
  config,
  ...
}:
{
  flake =
    let
      system = "x86_64-linux";
      mkNixosSystem =
        host:
        withSystem system (
          { pkgs, ... }:
          inputs.nixpkgs.lib.nixosSystem {
            inherit pkgs;
            specialArgs = {
              inherit inputs;
              topcfg = config;
            };
            modules =
              with inputs;
              [
                disko.nixosModules.disko
                sops-nix.nixosModules.sops
                nixos-generators.nixosModules.all-formats
                nixos-facter-modules.nixosModules.facter
              ]
              ++ [
                { nixpkgs.hostPlatform = system; }
                ./${host}
                self.nixosModules.default
              ];
          }
        );
    in
    {
      nixosConfigurations = {
        laptop = mkNixosSystem "laptop";
        server = mkNixosSystem "server";
        iso = mkNixosSystem "iso";
        vm = mkNixosSystem "vm";
      };
    };
}
