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
        apple-sf-pro
        apple-sf-mono
        apple-new-york
        apple-color-emoji
        apple-pingfang
        sarasa-gothic
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts
        source-han-sans
        source-han-serif
        source-han-mono
        nerd-fonts.symbols-only
        twemoji-color-font
        noto-fonts-color-emoji
        maple-mono.Normal-CN
      ];
      fontconfig = {
        subpixel.rgba = "rgb";
        defaultFonts = {
          serif = [
            "New York Medium"
            "Source Han Serif SC"
            "Noto Serif CJK SC"
            "Symbols Nerd Font"
          ];
          sansSerif = [
            "PingFang SC"
            "SF Pro Rounded"
            "Source Han Sans SC"
            "Noto Sans CJK SC"
            "Symbols Nerd Font"
          ];
          monospace = [
            "SF Mono"
            "Source Han Mono SC"
            "Noto Sans Mono CJK SC"
            "Maple Mono Normal CN"
            "Symbols Nerd Font Mono"
          ];
          emoji = [
            "Apple Color Emoji"
            "Twitter Color Emoji"
            "Symbols Nerd Font"
          ];
        };
      };
    };
  };
}
