{ inputs, ... }:
{
  imports = [ inputs.home-manager.flakeModules.home-manager ];
  flake.homeModules.default =
    { lib, ... }:
    {
      imports = lib.importModule' ./.;
    };
}
