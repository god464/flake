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
  config = mkIf cfg.enable {
    fonts = {
      packages = with pkgs; [
        apple-color-emoji
        sarasa-gothic
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts
        source-han-sans
        source-han-serif
        source-han-mono
        twemoji-color-font
        noto-fonts-color-emoji
      ];
      fontconfig = {
        subpixel.rgba = "rgb";
        defaultFonts = {
          serif = [
            "Source Han Serif SC"
            "Noto Serif CJK SC"
          ];
          sansSerif = [
            "SF Pro Rounded"
            "Source Han Sans SC"
            "Noto Sans CJK SC"
          ];
          monospace = [
            "Source Han Mono SC"
            "Noto Sans Mono CJK SC"
            "Maple Mono Normal CN"
          ];
          emoji = [
            "Apple Color Emoji"
            "Twitter Color Emoji"
          ];
        };
      };
    };
  };
}
