{
  config,
  lib,
  pkgs,
  inputs,
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
      default = with pkgs.kdePackages; [ dragon ];
    };
    excludePackages = mkOption {
      type = types.listOf types.package;
      default = with pkgs.kdePackages; [
        kate
        kwrited
        baloo
        milou
        baloo-widgets
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
      systemPackages = lib.mkAfter (cfg.includePackages ++ [ pkgs.wl-clipboard ]);
    };

    home-manager = {
      sharedModules = [ inputs.plasma-manager.homeManagerModules.plasma-manager ];
      users.cl = {
        programs = {
          plasma = {
            enable = true;
            input.touchpads = [
              {
                naturalScroll = true;
                tapToClick = true;
                vendorId = "06CB";
                productId = "CD50";
                name = "SYNA32AC:00 06CB:CD50 Touchpad";
              }
            ];
          };
        };
      };
    };
  };
}
