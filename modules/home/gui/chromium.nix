{
  osConfig,
  lib,
  pkgs,
  ...
}:
let
  cfg = osConfig.programs'.chromium;
in
{
  config = lib.mkIf cfg.enable {
    programs.chromium = {
      enable = true;
      package = pkgs.ungoogled-chromium;
    };
  };
}
