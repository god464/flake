{ lib, ... }:
let
  inherit (lib) mkEnableOption;
in
{
  options.programs'.zed.enable = mkEnableOption "zed";
}
