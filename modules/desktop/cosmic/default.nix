{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.desktop.cosmic;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.desktop.cosmic = {
    enable = mkEnableOption "cosmic";
  };
  config = mkIf cfg.enable {
    services = {
      desktopManager.cosmic.enable = true;
      displayManager.cosmic-greeter.enable = true;
      pipewire = {
        enable = true;
        alsa.enable = true;
        pulse.enable = true;
        jack.enable = true;
        wireplumber.enable = true;
      };
    };
    programs = {
      firefox = {
        enable = true;
        policies = {
          DisableAccounts = true;
          DisableAppUpdate = true;
          DisablePocket = true;
          NoDefaultBookmarks = true;
        };
      };
      thunderbird = {
        enable = true;
        policies.DisableAppUpdate = true;
      };
    };
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          fcitx5-rime
          fcitx5-gtk
          fcitx5-tokyonight
          fcitx5-chinese-addons
          rime-data
        ];
      };
    };
    security.polkit.enable = true;
    environment.systemPackages = lib.mkAfter ([ pkgs.wl-clipboard ]);
  };
}
