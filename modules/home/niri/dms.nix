{ osConfig, lib, ... }:
let
  cfg = osConfig.programs.niri;
in
{
  config = lib.mkIf cfg.enable {
    programs.dank-material-shell = {
      enable = true;
      systemd.enable = true;
      niri.enableKeybinds = true;
    };
  };
}
