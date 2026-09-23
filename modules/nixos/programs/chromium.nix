{ config, lib, ... }:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.programs'.chromium;
in
{
  options.programs'.chromium.enable = mkEnableOption "chromium";
  config = mkIf cfg.enable {
    programs.chromium.enable = true;
  };
}
