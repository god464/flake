{
  flake =
    { lib, ... }:
    {
      nixosModules.default = {
        imports = lib.importModule' ./nixos/.;
      };
      homeModules.default = {
        imports = lib.importModule' ./home/.;
      };
    };
}
