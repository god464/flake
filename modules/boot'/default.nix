{ lib, ... }:
{
  imports = lib.importModule' ./.;
}
