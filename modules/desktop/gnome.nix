{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.gvariant) mkUint32;
  cfg = config.desktop'.gnome;
in
{
  options.desktop'.gnome.enable = mkEnableOption "Gnome";
  config = mkIf cfg.enable {
    services = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      gnome = {
        evolution-data-server.enable = true;
        gnome-keyring.enable = true;
        sushi.enable = true;
      };
    };
    programs = {
      evolution.enable = true;
      dconf = {
        enable = true;
        profiles.user.databases = [
          {
            lockAll = true;
            settings = {
              "org/gnome/desktop/interface" = {
                clock-show-seconds = true;
                clock-show-weekday = true;
              };
              "org/gnome/mutter".experimental-features = [ "scale-monitor-framebuffer" ];
              "org/gnome/desktop/datetime".automatic-timezone = true;
              "org/gnome/shell".favorite-apps = [
                "firefox.desktop"
                "thunderbird.desktop"
                "org.gnome.Nautilus.desktop"
              ];
              "org/gnome/desktop/peripherals/touchpad".two-finger-scrolling-enabled = true;
              "org/gnome/desktop/screen-time-limits".daily-limit-enabled = true;
              "org/gnome/desktop/break-reminders/movement" = {
                duration-seconds = mkUint32 300;
                interval-seconds = mkUint32 1800;
                play-sound = true;
              };
            };
          }
        ];
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
          gnome-characters
          simple-scan
          snapshot
          yelp
        ];
        systemPackages = with pkgs; [
          gnome-tweaks
          wl-clipboard
        ];
      };
    };
  };
}
