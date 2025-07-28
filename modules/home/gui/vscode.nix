{ osConfig, lib, ... }:
let
  cfg = osConfig.programs.vscode;
in
{
  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      mutableExtensionsDir = true;
    };
  };
}
