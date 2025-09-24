{ osConfig, lib, ... }:
let
  cfg = osConfig.programs'.zed;
in
{
  config = lib.mkIf cfg.enable { programs.zed-editor.enable = true; };
}
