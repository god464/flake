{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.displayManager;
  inherit (lib) mkIf;
in
{
  config = mkIf cfg.enable {
    programs.chromium.enable = true;
    environment.systemPackages = [
      (pkgs.chromium.override {
        commandLineArgs = [
          "--enable-features=AcceleratedVideoEncoder"
          "--ignore-gpu-blocklist"
          "--enable-zero-copy"
        ];
      })
    ];
  };
}
