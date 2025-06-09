{
  flake = {
    nixosModules.default =
      { lib, ... }:
      {
        imports = lib.importModule' ./nixos/.;
      };
    homeModules.default =
      { lib, ... }:
      {
        imports = lib.importModule' ./home/.;
      };
  };
}
