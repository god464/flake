{ lib, ... }:
{
  imports = lib.importModule' ./.;
}