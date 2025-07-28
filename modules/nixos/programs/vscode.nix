{ config, lib, ... }:
let
  cfg = config.programs'.vscode;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.programs'.vscode.enable = mkEnableOption "vscode";
  config = mkIf cfg.enable { programs.vscode.enable = true; };
}
