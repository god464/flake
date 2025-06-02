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
    programs.dconf = {
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
              duration-seconds = 300;
              interval-seconds = 1800;
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
        simple-scan
        snapshot
        yelp
      ];
      systemPackages =
        with pkgs;
        [
          gnome-tweaks
          wl-clipboard
        ]
        ++ (with pkgs.gnomeExtensions; [
          paperwm
          blur-my-shell
        ]);
    };
  };
}
