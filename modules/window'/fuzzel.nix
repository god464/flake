{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.window'.niri;
in
{
  config = mkIf cfg.enable {
    home-manager.users.cl.programs.fuzzel.enable = true;
  };
}
