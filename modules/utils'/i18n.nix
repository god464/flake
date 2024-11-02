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
  time.timeZone = "Asia/Shanghai";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "zh_CN.UTF-8/UTF-8"
    ];
    extraLocaleSettings = {
      LC_CTYPE = "zh_CN.UTF-8";
    };
    inputMethod = mkIf cfg.enable {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          fcitx5-chinese-addons
          fcitx5-pinyin-zhwiki
          fcitx5-lua
          fcitx5-pinyin-moegirl
          fcitx5-nord
        ];
      };
    };
  };
  console.useXkbConfig = true;
}
