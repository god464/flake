{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    sops-nix.url = "github:Mic92/sops-nix";
    flake-parts.url = "github:hercules-ci/flake-parts";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    inputs@{ flake-parts, nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      debug = true;
      systems = [ "x86_64-linux" ];
      flake.nixosConfigurations = {
        router = nixpkgs.lib.nixosSystem {
          modules = [
            inputs.disko.nixosModules.disko
            inputs.sops-nix.nixosModules.sops
            inputs.nixos-cosmic.nixosModules.default
            ./disko/server.nix
            ./host/router
            ./modules
          ];
        };
        builder = nixpkgs.lib.nixosSystem {
          modules = [
            inputs.home-manager.nixosModules.home-manager
            inputs.disko.nixosModules.disko
            inputs.sops-nix.nixosModules.sops
            inputs.nixos-cosmic.nixosModules.default
            ./disko/desktop.nix
            ./host/builder
            ./modules
          ];
        };
      };
      perSystem =
        { pkgs, ... }:
        {
          devShells.vterm = pkgs.mkShell {
            packages = with pkgs; [
              cmake
              emacs
              gcc
              gnumake
              libtool
            ];
          };
          formatter = pkgs.nixfmt-rfc-style;
        };
    };
}
