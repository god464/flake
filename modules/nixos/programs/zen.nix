{ lib, ... }:
let
  inherit (lib) mkEnableOption;
in
{
  options.programs'.zen.enable = mkEnableOption "zen";
}
