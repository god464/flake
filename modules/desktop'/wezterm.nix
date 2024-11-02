{
  inputs,
  config,
  lib,
  ...
}:
let
  cfg = config.services.displayManager;
  inherit (lib) mkIf;
in
{
  config = mkIf cfg.enable {
    home-manager.users.cl = {
      programs.wezterm.enable = true;
      xdg.configFile.wezterm = {
        source = inputs.ggterm;
        recursive = true;
      };
    };
  };
}
