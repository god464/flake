{ osConfig, lib, ... }:
let
  cfg = osConfig.programs.niri;
in
{
  config = lib.mkIf cfg.enable {
    # services.hyprpolkitagent.enable = true;
  };
}
