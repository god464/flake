{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.desktop'.gnome;
in
{
  options.desktop'.gnome.enable = mkEnableOption "Gnome";
  config = mkIf cfg.enable {
    services = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
    environment = {
      gnome.excludePackages = with pkgs; [
        gnome-weather
        gnome-maps
        geary
        gnome-music
        gnome-tour
        gnome-text-editor
        gnome-console
        gnome-contacts
        simple-scan
        snapshot
        yelp
      ];
      systemPackages =
        with pkgs;
        [ gnome-tweaks ]
        ++ (with pkgs.gnomeExtensions; [
          paperwm
          blur-my-shell
        ]);
    };
  };
}
