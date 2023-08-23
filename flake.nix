{
  description = "CL Flake ";
  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
  };
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, nur, disko, lanzaboote, sops-nix, ... }@inputs: {
    nixosConfigurations =
      {
        vm = nixpkgs.lib.nixosSystem {
          modules = [
            disko.nixosModules.disko
            {
              disko.devices = import ./hosts/vm/disko-config.nix;
            }
            ./hosts/vm
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs; };
                users = {
                  cl = import ./home/vm.nix;
                };
              };
            }
          ];
        };

        #      TODO
        lap = nixpkgs.lib.nixosSystem {
          modules = [
            disko.nixosModules.disko
            {
              disko.devices = import ./hosts/lap/disko-config.nix;
            }
            ./hosts/lap
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs; };
                users = {
                  cl = import ./home/lap.nix;
                };
              };
            }
          ];
        };
      };
  };
}
