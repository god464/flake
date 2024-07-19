{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
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
  };
  outputs =
    inputs@{ flake-parts, nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      flake = {
        nixosConfigurations = {
          router = nixpkgs.lib.nixosSystem {
            modules = [
              inputs.disko.nixosModules.disko
              inputs.sops-nix.nixosModules.sops
              ./modules
              ./disko/server.nix
              ./host/router

            ];
          };
          builder = nixpkgs.lib.nixosSystem {
            modules = [
              inputs.disko.nixosModules.disko
              inputs.sops-nix.nixosModules.sops
              inputs.home-manager.nixosModules.home-manager
              ./modules
              ./disko/desktop.nix
              ./host/builder
            ];
          };
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
