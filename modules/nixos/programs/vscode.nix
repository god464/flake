{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs'.vscode;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.programs'.vscode.enable = mkEnableOption "vscode";
  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode.override {
        commandLineArgs = [
          "--enable-features=AcceleratedVideoEncoder"
          "--password-store=gnome"
          "--ignore-gpu-blocklist"
          "--enable-zero-copy"
          "--gtk-version=4"
          "--wayland-text-input-version=3"
          "--enable-wayland-ime"
        ];
      };
    };
  };
}
