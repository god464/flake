{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.window'.niri;
in
{
  config = mkIf cfg.enable {
    programs.waybar.enable = true;
    home-manager.users.cl.programs.waybar = {
      enable = true;
      systemd.enable = true;
    };
  };
}
