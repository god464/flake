{ config, lib, ... }:
let
  inherit (lib) mkEnableOption;
in
{
  options.window'.wm.enable = mkEnableOption "window manager";
  config = {
  };
}
