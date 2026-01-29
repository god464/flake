{
  inputs,
  withSystem,
  self,
  config,
  lib,
  ...
}:
{
  flake = withSystem "x86_64-linux" (
    { pkgs, ... }:
    {
      nixosConfigurations =
        let
          commonModules = with inputs; [
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
            nixos-generators.nixosModules.all-formats
            nixos-facter-modules.nixosModules.facter
            self.nixosModules.default
          ];
          mkConfig =
            host:
            inputs.nixpkgs.lib.nixosSystem {
              inherit pkgs;
              specialArgs = {
                inherit inputs;
                topcfg = config;
              };
              modules = commonModules ++ [ ./${host} ];
            };
        in
        lib.genAttrs [ "laptop" "server" "iso" "vm" ] mkConfig
        // {
          minimal = inputs.nixpkgs.lib.nixosSystem { modules = [ ./minimal ]; };
        };
    }
  );
}
