{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkOption
    types
    mkIf
    mkEnableOption
    ;
  cfg = config.desktop'.kde;

in
{
  options.desktop'.kde = {
    enable = mkEnableOption "KDE";
    includePackages = mkOption { type = types.listOf types.package; };
    excludePackages = mkOption { type = types.listOf types.package; };
  };
  config = mkIf cfg.enable {
    services = {
      desktopManager.plasma6 = {
        enable = true;
        enableQt5Integration = false;
      };
      displayManager.sddm = {
        enable = true;
        wayland = {
          enable = true;
          compositor = "kwin";
        };
      };
    };
    security.polkit.enable = true;
    environment = {
      plasma6.excludePackages = cfg.excludePackages;
      systemPackages = lib.mkAfter (cfg.includePackages ++ [ pkgs.wl-clipboard ]);
    };
  };
}
