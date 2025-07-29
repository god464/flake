{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.programs'.chromium;
in
{
  options.programs'.chromium.enable = mkEnableOption cfg.enable;
  config = mkIf cfg.enable {
    programs.chromium.enable = true;
    environment.systemPackages = [
      pkgs.ungoogled-chromium.override
      {
        commandLineArgs = [
          "--enable-features=AcceleratedVideoEncoder"
          "--ignore-gpu-blocklist"
          "--enable-zero-copy"
          "--gtk-version=4"
          "--wayland-text-input-version=3"
          "--enable-wayland-ime"
        ];
      }
    ];
  };
}
