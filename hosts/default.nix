{
  inputs,
  withSystem,
  self,
  config,
  lib,
  ...
}:
{
  flake = withSystem "x86_64-linux" (_: {
    nixosConfigurations =
      let
        commonModules =
          with inputs;
          [
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
            nixos-facter-modules.nixosModules.facter
            self.nixosModules.default
          ]
          ++ [
            (_: {
              nixpkgs.pkgs = withSystem "x86_64-linux" ({ pkgs, ... }: pkgs);
            })
          ];
        mkConfig =
          host:
          inputs.nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs;
              topcfg = config;
            };
            modules = commonModules ++ [ ./${host} ];
          };
      in
      lib.genAttrs [ "laptop" "server" "iso" ] mkConfig
      // {
        minimal = inputs.nixpkgs.lib.nixosSystem {
          modules = [ ./minimal ];
          specialArgs = { inherit inputs; };
        };
      };
  });
}
