{
  inputs,
  withSystem,
  config,
  lib,
  ...
}:
{
  flake.nixosConfigurations =
    let
      inherit (inputs)
        disko
        sops-nix
        nixos-facter-modules
        nixpkgs
        ;
      commonModules = [
        disko.nixosModules.disko
        sops-nix.nixosModules.sops
        nixos-facter-modules.nixosModules.facter
        config.flake.nixosModules.default
        (
          { config, lib, ... }:
          lib.mkIf (config.hardware.facter.report ? system) {
            nixpkgs.pkgs = withSystem config.hardware.facter.report.system ({ pkgs, ... }: pkgs);
          }
        )
      ];
      mkNixosConfig =
        host:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            topcfg = config;
          };
          modules = commonModules ++ [ ./${host} ];
        };
    in
    lib.genAttrs [ "laptop" "server" ] mkNixosConfig
    // {
      iso = nixpkgs.lib.nixosSystem {
        modules = [ ./iso ];
        specialArgs = { inherit inputs; };
      };
      minimal = nixpkgs.lib.nixosSystem {
        modules = [ ./minimal ];
        specialArgs = { inherit inputs; };
      };
    };
}
