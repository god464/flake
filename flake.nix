{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    sops-nix.url = "github:Mic92/sops-nix";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    inputs@{ self, nixpkgs, ... }:
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
      nixosConfigurations.router = nixpkgs.lib.nixosSystem {
        specialArgs.inputs = inputs;
        modules = [
          inputs.disko.nixosModules.disko
          inputs.sops-nix.nixosModules.sops
          ./disko/server.nix
          ./host/router
        ];
      };
      nixosConfigurations.builder = nixpkgs.lib.nixosSystem {
        specialArgs.inputs = inputs;
        modules = [
          inputs.disko.nixosModules.disko
          inputs.sops-nix.nixosModules.sops
          inputs.home-manager.nixosModules.home-manager
          ./disko/desktop.nix
          ./host/builder
        ];
      };
    };
}
