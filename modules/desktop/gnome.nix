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
    };
    programs.dconf = {
      enable = true;
      profiles.user.databases = [
        {
          lockAll = true;
          settings = {
            "org/gnome/shell" = {
              disable-user-extensions = false;
              enabled-extensions = [ "paperwm@paperwm.github.com" ];
            };
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
            "org/gnome/settings-daemon/plugins/media-keys" = {
              screensaver = [ "<Super>Escape" ];
            };
            "org/gnome/shell/extensions/paperwm/keybindings" = {
              switch-down = [ "<Super>j" ];
              switch-left = [ "<Super>h" ];
              switch-right = [ "<Super>l" ];
              switch-up = [ "<Super>k" ];
              toggle-scratch-window = [ "<Super>m" ];
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
        ++ (with pkgs.gnomeExtensions; [ paperwm ]);
    };
  };
}
