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
    includePackages = mkOption {
      type = types.listOf types.package;
      default = [ ];
    };
    excludePackages = mkOption {
      type = types.listOf types.package;
      default = with pkgs.kdePackages; [
        kate
        kwrited
      ];
    };
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
      persistence."/persist".users.cl.files = [
        ".config/baloofilerc"
        ".config/kcminputrc"
        ".config/kwalletrc"
        ".config/kwinoutputconfig.json"
        ".config/dolphinrc"
        ".config/plasma-org.kde.plasma.desktop-appletsrc"
        ".config/spectaclerc"
      ];
      systemPackages = lib.mkAfter (cfg.includePackages ++ [ pkgs.wl-clipboard ]);
    };
  };
}
