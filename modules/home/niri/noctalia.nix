{
  osConfig,
  lib,
  inputs,
  ...
}:
let
  cfg = osConfig.programs.niri;
in
{
  programs.noctalia = lib.mkIf cfg.enable {
    enable = true;
    package = inputs.noctalia.packages."x86_64-linux".default;
  };
}
